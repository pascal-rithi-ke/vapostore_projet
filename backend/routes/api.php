<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

use App\Http\Controllers\UserController;

use App\Http\Controllers\ProductController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\OrderController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

// Routes pour les utilisateurs
Route::post('/register', [UserController::class, 'register']); // Ajouter un utilisateur
Route::get('/users/{id}', [UserController::class, 'showOne']);    // Afficher un utilisateur spécifique
Route::put('/users/{id}', [UserController::class, 'update']);  // Mettre à jour un utilisateur
Route::delete('/users/{id}', [UserController::class, 'delete']); // Supprimer un utilisateur

// Routes pour l'authentification des utilisateurs
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout']);
Route::get('/user', [AuthController::class, 'getUser'])->middleware('auth:sanctum');

// Route pour les produits
Route::get('/product/{id}', [ProductController::class, 'showOne']); // Afficher un produit spécifique

// Route pour les paniers
Route::get('/cart/{id}', [CartController::class, 'showOne']); // Afficher un produit du panier
Route::post('/cart/{id}', [CartController::class, 'addOne']); // Ajouter un produit au panier
Route::put('/cart/{id}', [CartController::class, 'update']); // Modifier un produit du panier
Route::delete('/cart/{id}', [CartController::class, 'delete']); // Supprimer un produit du panier

// Route pour les commandes
Route::get('/order{id}', [OrderController::class, 'showOne']); // Ajouter une commande validée
Route::post('/order{id}', [OrderController::class, 'addOne']); // Ajouter une commande validée