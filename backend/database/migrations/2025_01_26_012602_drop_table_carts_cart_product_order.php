<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        // Supprimer les tables dans l'ordre inverse des relations
        Schema::dropIfExists('orders');
        Schema::dropIfExists('carts');
        Schema::dropIfExists('cart_products');
    }

    public function down()
    {
        // Rien à faire ici, car on ne peut pas recréer les tables avec leurs données
    }
};