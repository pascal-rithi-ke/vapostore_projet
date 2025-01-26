<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CheckoutController extends Controller
{
    public function processCheckout(Request $request)
    {
        $request->validate([
            'address' => 'required|string',
            'city' => 'required|string',
            'postal_code' => 'required|string',
            'total_price' => 'required|numeric',
            'total_quantity' => 'required|integer',
        ]);

        $user = $request->user();

        // Récupère le panier actif
        $cart = $user->activeCart();

        if (!$cart) {
            return response()->json([
                'message' => 'No active cart found.',
            ], 404);
        }

        // Crée une nouvelle commande
        $order = $user->orders()->create([
            'address' => $request->address,
            'city' => $request->city,
            'postal_code' => $request->postal_code,
            'total_price' => $request->total_price,
            'item_number' => $request->total_quantity,
            'cart_id' => $cart->id,
        ]);

        // Marque le panier comme inactif
        $cart->update(['is_active' => 0]);

        // Crée un nouveau panier actif
        $user->carts()->create([
            'is_active' => true,
        ]);

        return response()->json([
            'message' => 'Order processed successfully.',
            'order_id' => $order->id,
        ], 201);
    }
}
