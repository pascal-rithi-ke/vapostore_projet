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
}
