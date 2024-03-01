<?php
namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Support\Facades\Lang;

class VerifyEmail extends Notification
{
    use Queueable;

    public function __construct(){}

    public function via($notifiable){
        return ['mail'];
    }

    public function toMail($notifiable){
        $verificationUrl = $this->verificationUrl($notifiable);

        return (new MailMessage)
            ->subject(Lang::get('Vérifiez votre adresse email'))
            ->greeting('Bonjour !')
            ->line(Lang::get('Veuillez cliquer sur le bouton ci-dessous pour vérifier votre adresse email.'))
            ->action(Lang::get('Vérifier Email'), $verificationUrl)
            ->line(Lang::get('Si vous n\'avez pas créé de compte, aucune action supplémentaire n\'est requise.'));
    }

    protected function verificationUrl($notifiable){
        $frontendUrl = config('frontend.url');
        return $frontendUrl . '/verification-mail?token=' . $notifiable->verification_token;
    }
}
