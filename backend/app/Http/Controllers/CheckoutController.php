<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CheckoutController extends Controller
{
    public function processCheckout(Request $request)
    {
        $request->validate([
            'city' => 'required|string',
            'address' => 'required|string',
            'postal_code' => 'required|string',
            'cart' => 'required|array',
            'total_price' => 'required|numeric',
            'total_quantity' => 'required|integer',
        ]);

        $user = $request->user();

        // Récupère le panier actif
        $cart = $user->carts()->active()->with('products')->first();

        if (!$cart) {
            return response()->json([
                'message' => 'No active cart found.',
            ], 404);
        }

        // Crée une nouvelle commande
        $order = $user->orders()->create([
            'city' => $request->city,
            'address' => $request->address,
            'postal_code' => $request->postal_code,
            'total_price' => $request->total_price,
            'item_number' => $request->total_quantity,
            'cart_id' => $cart->id,
        ]);

        // Met à jour le statut du panier
        $cart->update(['is_active' => false]);

        return response()->json([
            'message' => 'Order processed successfully.',
            'order_id' => $order->id,
        ], 201);
    }
}
