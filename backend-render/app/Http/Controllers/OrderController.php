<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function getUserOrders(Request $request)
    {
        $user = $request->user();

        // Récupère les commandes avec leurs produits et panier associés
        $orders = $user->orders()->with('cart.products')->latest()->get();

        return response()->json($orders, 200);
    }
}
