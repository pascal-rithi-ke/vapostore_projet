<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CartProductController extends Controller
{
    //
    public function addProduct(Request $request)
    {
        $request->validate([
            'product_id' => 'required|integer|exists:products,id',
            'quantity' => 'required|integer|min:1',
            'price' => 'required|numeric|min:0',
        ]);
    
        $user = $request->user();
    
        $cart = $user->carts()->active()->firstOrCreate([
            'user_id' => $user->id,
        ]);
    
        // Vérifier si le produit existe déjà dans le panier
        $existingProduct = $cart->products()->where('product_id', $request->product_id)->first();
    
        if ($existingProduct) {
            // Mettre à jour la quantité et le prix si le produit existe déjà
            $cart->products()->updateExistingPivot($request->product_id, [
                'quantity' => $existingProduct->pivot->quantity + $request->quantity,
                'price' => $request->price,
            ]);
        } else {
            // Ajouter un nouveau produit au panier
            $cart->products()->attach($request->product_id, [
                'quantity' => $request->quantity,
                'price' => $request->price,
            ]);
        }
    
        return response()->json([
            'data' => $cart->products,
            'message' => 'Product added to cart successfully',
        ], 200);
    }    

    public function showOne(Request $request)
    {
        $user = $request->user();
        $cart = $user->carts()->active()->with('products')->first();
    
        if (!$cart) {
            return response()->json([
                'data' => [],
                'message' => 'No active cart found',
            ], 200);
        }
    
        // Inclure les données pivot (quantity, price) dans la réponse
        $products = $cart->products->map(function ($product) {
            return [
                'id' => $product->id,
                'name' => $product->name,
                'price' => $product->pivot->price,
                'quantity' => $product->pivot->quantity,
                'image' => $product->image ?? '', // Image par défaut si elle n'existe pas
            ];
        });
    
        return response()->json([
            'data' => $products,
            'message' => 'Active cart found',
        ], 200);
    }    

    public function updateCart(Request $request)
    {
        $request->validate([
            'product_id' => 'required|integer|exists:products,id',
            'quantity' => 'required|integer|min:1',
            'price' => 'required|numeric|min:0',
        ]);
    
        $user = $request->user();
    
        $cart = $user->carts()->active()->first();
    
        if (!$cart) {
            return response()->json([
                'data' => [],
                'message' => 'No active cart found',
            ], 200);
        }
    
        // Vérifier si le produit existe déjà dans le panier
        $existingProduct = $cart->products()->where('product_id', $request->product_id)->first();
    
        if ($existingProduct) {
            // Mettre à jour la quantité et le prix si le produit existe déjà
            $cart->products()->updateExistingPivot($request->product_id, [
                'quantity' => $request->quantity,
                'price' => $request->price,
            ]);
    
            return response()->json([
                'data' => $cart->products,
                'message' => 'Cart updated successfully',
            ], 200);
        }
    
        return response()->json([
            'data' => [],
            'message' => 'Product not found in cart',
        ], 404);
    }

    public function deleteProduct(Request $request)
    {
        $request->validate([
            'product_id' => 'required|integer|exists:products,id',
        ]);
    
        $user = $request->user();
    
        $cart = $user->carts()->active()->first();
    
        if (!$cart) {
            return response()->json([
                'data' => [],
                'message' => 'No active cart found',
            ], 200);
        }
    
        // Supprimer le produit du panier
        $cart->products()->detach($request->product_id);
    
        return response()->json([
            'data' => $cart->products,
            'message' => 'Product removed from cart successfully',
        ], 200);
    }
}
