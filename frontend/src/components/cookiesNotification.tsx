"use client"
import { Button, notification } from 'antd';

import React, { useEffect } from 'react';
import { useConsent } from '@/contexts/CookiesConsentContext';
export default function CookiesNotification() {
    const { consentStatus, setConsent } = useConsent();

    const handleAccept = () => setConsent('accepted');
    const handleDecline = () => setConsent('declined');

    useEffect(() => {
        console.log('consentStatus', consentStatus)
        // Vérifie si l'utilisateur a déjà accepté/refusé les cookies
        if (consentStatus === 'not_set') {
            notification.open({
                message: 'Cookies et confidentialité',
                placement: 'bottomRight',
                description:
                    'Nous utilisons des cookies pour améliorer votre expérience. En continuant à utiliser notre site, vous acceptez notre utilisation des cookies.',
                btn: (
                    <div>
                        <Button
                            type="primary"
                            size="large"
                            onClick={() => {
                                handleAccept()
                                notification.destroy('cookiesNotification');
                            }}
                        >
                            Accepter
                        </Button>
                        <Button
                            size="large"
                            style={{ marginLeft: '10px' }}
                            onClick={() => {
                                handleDecline()
                                notification.destroy('cookiesNotification');
                            }}
                        >
                            Refuser
                        </Button>
                    </div>
                ),
                key: 'cookiesNotification',
                duration: 0, // La notification reste affichée jusqu'à interaction
                onClose: () => notification.destroy('cookiesNotification'),
            });
        }else if(consentStatus === 'accepted'){
            notification.destroy('cookiesNotification');
        }
    }, [consentStatus]);

    return <></>;
}
