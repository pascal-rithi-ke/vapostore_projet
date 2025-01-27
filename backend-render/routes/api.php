<?php

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

use App\Http\Controllers\UserController;

use App\Http\Controllers\TypeProduitController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CartProductController;
use App\Http\Controllers\CheckoutController;
use App\Http\Controllers\OrderController;

// Routes pour les utilisateurs
#Route::get('/users/{id}', [UserController::class, 'showOne']);    // Afficher un utilisateur spécifique
#Route::put('/users/{id}', [UserController::class, 'update']);  // Mettre à jour un utilisateur
#Route::delete('/users/{id}', [UserController::class, 'delete']); // Supprimer un utilisateur

// Api is running
Route::get('/', function () {
    return response()->json(['message' => 'Api is running']);
});

// Routes pour l'authentification des utilisateurs
Route::post('/register', [UserController::class, 'register']); // Ajouter un utilisateur
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout']);
Route::get('/user', [AuthController::class, 'getUser'])->middleware('auth:sanctum');

// Route pour les types de produits
Route::get('/type-products', [TypeProduitController::class, 'showTypes']); // Afficher tous les types de produits

// Route pour les produits
Route::get('/products/type/{id}', [ProductController::class, 'showAll']); // Afficher tous les produits par catégorie
Route::get('/products/{id}', [ProductController::class, 'showOne']); // Afficher un produit spécifique

// Route pour les paniers produits
Route::get('/cart', function (Request $request) {
    $user = $request->user();
    $cart = $user->activeCart(); // Utilise la méthode activeCart pour récupérer le panier actif

    if (!$cart) {
        return response()->json([
            'data' => [],
            'message' => 'No active cart found.',
        ], 200);
    }

    return response()->json([
        'data' => $cart->products()->get()->map(function ($product) {
            return [
                'id' => $product->id,
                'name' => $product->name,
                'price' => $product->pivot->price,
                'quantity' => $product->pivot->quantity,
                'image' => $product->image ?? null,
            ];
        }),
        'message' => 'Active cart found.',
    ], 200);
})->middleware('auth:sanctum');

Route::post('/add-product', [CartProductController::class, 'addProduct'])->middleware('auth:sanctum'); // Ajouter un produit au panier

Route::put('/update-cart-bulk', function (Request $request) {
    $user = $request->user();
    $cart = $user->activeCart();

    if (!$cart) {
        return response()->json([
            'message' => 'No active cart found.',
        ], 404);
    }

    foreach ($request->updates as $update) {
        $productId = $update['product_id'];
        $quantity = $update['quantity'];

        if (is_null($quantity)) {
            // Supprimer le produit du panier
            $cart->products()->detach($productId);
        } else {
            // Mettre à jour la quantité
            $cart->products()->updateExistingPivot($productId, ['quantity' => $quantity]);
        }
    }

    return response()->json(['message' => 'Cart updated successfully.'], 200);
})->middleware('auth:sanctum');

Route::delete('/remove-product', [CartProductController::class, 'deleteProduct'])->middleware('auth:sanctum'); // Supprimer un produit du panier

// Route pour le checkout
Route::post('/checkout', [CheckoutController::class, 'processCheckout'])->middleware('auth:sanctum');

// Route pour les commandes
Route::get('/orders', [OrderController::class, 'getUserOrders'])->middleware('auth:sanctum'); // Afficher toutes les commandes d'un utilisateur