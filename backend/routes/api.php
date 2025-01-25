<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

use App\Http\Controllers\UserController;

use App\Http\Controllers\ProductController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\OrderController;

// Routes pour les utilisateurs
#Route::get('/users/{id}', [UserController::class, 'showOne']);    // Afficher un utilisateur spécifique
#Route::put('/users/{id}', [UserController::class, 'update']);  // Mettre à jour un utilisateur
#Route::delete('/users/{id}', [UserController::class, 'delete']); // Supprimer un utilisateur

// Routes pour l'authentification des utilisateurs
Route::post('/register', [UserController::class, 'register']); // Ajouter un utilisateur
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout']);
Route::get('/user', [AuthController::class, 'getUser'])->middleware('auth:sanctum');

// Route pour les produits
Route::get('/product/{id}', [ProductController::class, 'showOne']); // Afficher un produit spécifique

// Route pour les paniers
Route::get('/cart/{id}', [CartController::class, 'showOne'])->middleware('auth:sanctum'); // Afficher un produit du panier
Route::post('/cart/{id}', [CartController::class, 'addOne'])->middleware('auth:sanctum'); // Ajouter un produit au panier
Route::put('/cart/{id}', [CartController::class, 'update'])->middleware('auth:sanctum'); // Modifier un produit du panier
Route::delete('/cart/{id}', [CartController::class, 'delete'])->middleware('auth:sanctum'); // Supprimer un produit du panier

// Route pour les commandes
Route::get('/order{id}', [OrderController::class, 'showOne'])->middleware('auth:sanctum'); // Ajouter une commande validée
Route::post('/order{id}', [OrderController::class, 'addOne'])->middleware('auth:sanctum'); // Ajouter une commande validée