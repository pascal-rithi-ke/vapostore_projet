<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        // Validate user credentials
        if (!Auth::attempt($request->only(['email', 'password']))) {
            return $this->failedRequest('', 'Invalid email address or password', 400);
        }

        // Regenerate the user's session to prevent session fixation
        $request->session()->regenerate();

        // Sign in user
        Auth::login(Auth::user());

        // Return data
        return $this->successfullRequest(Auth::user(), 'User successfully logged in', 200);
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
