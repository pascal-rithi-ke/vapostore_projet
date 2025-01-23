# Commande pour vérifier l'installation de composer
```composer --version```

# Commande pour vérifier la version de l'installation Laravel
```laravel --version```

# Installer les dépendences
```composer install```

# Lancer le serveur backend
1) Lancer XAMPP ou MAMP
2) ```php artisan serve```

# Génère une clé d’encryption
```php artisan key:generate```

# S'il y a un changement du schéma d'un model, réaliser une migration puis ajouter les changements dans le fichier de migration
1) ```php artisan make:migration ['nom de la migration'] [--option=nom_de_table_si_changement_une_table]```
2) ```php artisan migrate```

# Si on veut annuler une migration
```php artisan migrate:rollback```

# Crée un controller
```php artisan make:controller [nom controller]```