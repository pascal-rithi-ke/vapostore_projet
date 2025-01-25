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
        $product = Product::find($id);

        if (!$product) {
            return response()->json(['message' => 'Product not found'], 404);
        }

        return response()->json($product);
    }
}
