<?php
namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Support\Facades\Lang;

class ResetPass extends Notification {
    use Queueable;

    public function __construct(){}

    public function via($notifiable){
        return ['mail'];
    }

    public function toMail($notifiable){
        $resetPasswordUrl = $this->resetUrl($notifiable);

        return (new MailMessage)
            ->subject(Lang::get('Réinitialisation du mot de passe'))
            ->greeting('Bonjour !')
            ->line(Lang::get('Vous recevez cet email car nous avons reçu une demande de réinitialisation de mot de passe pour votre compte.'))
            ->action(Lang::get('Réinitialiser le mot de passe'), $resetPasswordUrl)
            ->line(Lang::get('Si vous n\'avez pas demandé de réinitialisation de mot de passe, aucune action supplémentaire n\'est requise.'));
    }

    protected function resetUrl($notifiable){
        $frontendUrl = config('frontend.url');
        return $frontendUrl . '/reinitialisation-mot-de-passe?token=' . $notifiable->password_reset_token;
    }
}
