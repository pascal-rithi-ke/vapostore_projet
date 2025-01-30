<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{
    // Ajouter un utilisateur
    public function register(Request $request){
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:255',
                'surname' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:users',
                'password' => 'required|string|min:6|confirmed',
            ]);
    
            $validated['password'] = bcrypt($validated['password']);
    
            $user = User::create($validated);
    
            return response()->json(['message' => 'User created successfully', 'user' => $user], 201);
        } catch (\Exception $e) {
            return response()->json(['message' => 'An error occurred while creating the user.'], 500);
        }
    }

    // Afficher un utilisateur spécifique
    public function showOne($id){
        $user = User::find($id);

        if($user){
            return response()->json(['user' => $user], 200);
        }else{
            return response()->json(['message' => 'User not found'], 404);
        }
    }

    // Mettre à jour un utilisateur
    public function update(Request $request, $id){
        $user = User::find($id);

        if($user){
            $validated = $request->validate([
                'name' => 'required|string|max:255',
                'surname' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:users,email,'.$id,
                'password' => 'required|string|min:6|confirmed',
            ]);

            $validated["password"] = bcrypt($validated["password"]);

            $user->update($validated);

            return response()->json(['message' => 'User updated successfully', 'user' => $user], 200);
        }else{
            return response()->json(['message' => 'User not found'], 404);
        }
    }

    // Supprimer un utilisateur
    public function delete($id){
        $user = User::find($id);

        if($user){
            $user->delete();
            return response()->json(['message' => 'User deleted successfully'], 200);
        }else{
            return response()->json(['message' => 'User not found'], 404);
        }
    }
}
