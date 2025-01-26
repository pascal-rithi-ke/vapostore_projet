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
            'total_price' => 'required|numeric|min:1', // Assure un prix total valide
            'total_quantity' => 'required|integer|min:1', // Assure qu'il y a au moins 1 article
        ]);

        $user = $request->user();

        // Récupère le panier actif
        $cart = $user->activeCart();

        // Vérifie si le panier est vide ou inexistant
        if (!$cart || $cart->products()->count() === 0) {
            return response()->json([
                'message' => 'Votre panier est vide. Veuillez ajouter des produits avant de valider la commande.',
            ], 400);
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
            'message' => 'Commande validée avec succès.',
            'order_id' => $order->id,
        ], 201);
    }
}
