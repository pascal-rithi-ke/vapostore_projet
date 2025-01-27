<?php

namespace App\Http\Controllers;

use App\Models\TypeProduit;
use Illuminate\Http\Request;

class TypeProduitController extends Controller
{
    // Afficher tous les types de produits
    public function showTypes()
    {
        $types = TypeProduit::all();
        $types->transform(function ($types) {
            $types->image = asset('images/products/' . $types->image);
            return $types;
        });

        return response()->json($types);
    }
}
