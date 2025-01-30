<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

use App\Models\User;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        // Validation des informations d'identification
        if (!Auth::attempt($request->only(['email', 'password']))) {
            return $this->failedRequest('', 'Invalid email address or password', 400);
        }
    
        // Régénération de la session
        $request->session()->regenerate();
    
        // Récupération de l'utilisateur connecté
        $user = User::where('email', $request->email)->first();
    
        // Récupérer le panier actif ou en créer un nouveau
        $cart = $user->carts()->active()->firstOrCreate([
            'user_id' => $user->id,
        ]);
    
        return $this->successfullRequest([
            'user' => $user,
            'cart' => $cart
        ], 'Connected successfully', 200);
    }

    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return response()->json(['message' => 'Déconnecté avec succès'], 200);
    }

    public function getUser(Request $request)
    {
        return response()->json($request->user());
    }

    public function failedRequest($data, $message, $status)
    {
        return response()->json([
            'data' => $data,
            'message' => $message
        ], $status);
    }

    public function successfullRequest($data, $message, $status)
    {
        return response()->json([
            'data' => $data,
            'message' => $message
        ], $status);
    }
}
