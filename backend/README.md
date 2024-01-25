<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">

<a href="https://www.php.net/releases/8.2/en.php"><img src="https://img.shields.io/badge/php-8.2.12-purple" alt="Version php"></a>
<a href="https://getcomposer.org/download/"><img src="https://img.shields.io/badge/composer-2.6.6-brown" alt="Version php"></a>
<a href="https://laravel.com/"><img src="https://img.shields.io/badge/laravel-10.41.0-blue" alt="Version laravel"></a>
<a href="https://fr.wikipedia.org/wiki/Licence_MIT"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## To install

### 0. [Optional] Install XAMPP (Apache + MariaDB + PHP)
https://www.apachefriends.org/fr/download.html

Add your PHP runtime directory to your Windows `PATH` environment variable and follow the installation procedure.
_Exemple_ : `E:\xampp\php`


### 1. Install PHP 8.2.12 
(do not install if you install XAMPP)

https://www.php.net/downloads

### 2. Install composer 2.6.6
https://getcomposer.org/download/


## How init
### 1. Clone GitHub repo for this project locally
```bash
git clone https://github.com/CESI-GRP-4/ressources_relationnelles.git
```

### 2. `cd` into your project
```bash
cd ./ressources_relationnelles/backend
```

### 3. Install Composer Dependencies
#### Activer l'extension ZIP pour PHP :
- Open your `php.ini`
- Find the line `;extension=zip`
- Delete the `;`

And 
```bash
composer install
```

### 4. Create a copy of your .env file
```bash
cp .example.env .env
```

### 5. Generate an app encryption key
```bash
php artisan key:generate
```

### For XAMPP user
To start your server in the correct directory, you can change Apache's `httpd.conf` by clicking (in xampp control panel) `apache/conf/httpd.conf` and adjust the entries for `DocumentRoot` and the corresponding `Directory` entry. Simply `Ctrl`+`F` and look for "htdocs" and change the entries to the correct path.

Change :

    DocumentRoot "C:/xampp/htdocs"
    <Directory "C:/xampp/htdocs">
 
To :

    DocumentRoot "{{yourPath}}/ressources_relationnelles/backend/public"
    <Directory "{{yourPath}}/ressources_relationnelles/backend/public">
    
### Now Laravel should be running
You can access it at http://localhost:80 .

## Sources / links
- clone repo laravel : https://devmarketer.io/learn/setup-laravel-project-cloned-github-com/
