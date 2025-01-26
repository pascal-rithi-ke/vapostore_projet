<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Add the columns to the orders table
        Schema::table('orders', function (Blueprint $table) {
            $table->string('address');
            $table->string('city');
            $table->string('number_address');
            $table->string('postal_code');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Remove the columns from the users table
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('address');
            $table->dropColumn('city');
            $table->dropColumn('number_address');
            $table->dropColumn('postal_code');
        });
    }
};
