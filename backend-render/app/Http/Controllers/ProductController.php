<?php

namespace App\Http\Controllers;

use App\Models\TypeProduit;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    // Afficher tous les produits par catégorie
    public function showAll($id)
    {
        $type = TypeProduit::with('products')->find($id);

        if (!$type) {
            return response()->json(['message' => 'Category not found'], 404);
        }

        return response()->json($type->products);
    }

    // Afficher un produit spécifique
    public function showOne($id)
    {
        // Charger la relation 'type' avec le produit
        $product = Product::with('type')->find($id);
    
        // Vérifier si le produit existe
        if (!$product) {
            return response()->json(['message' => 'Product not found'], 404);
        }
    
        // Vérifier si le type de produit est lié
        if (!$product->type) {
            return response()->json(['message' => 'Product type not found'], 404);
        }
    
        // Retourner les données du produit avec son type
        return response()->json([
            'id' => $product->id,
            'name' => $product->name,
            'description' => $product->description,
            'price' => $product->price,
            'type' => [
                'id' => $product->type->id,
                'libelle' => $product->type->libelle,
                'description' => $product->type->description,
            ],
        ]);
    }
    
}
