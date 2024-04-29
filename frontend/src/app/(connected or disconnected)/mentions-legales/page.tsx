// /mentions-legales/page.tsx
"use client"
import React from 'react';
import { Typography, Card } from 'antd';

const { Title, Paragraph } = Typography;

export default function MentionsLegales() {
       return (
              <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                     <Card
                            title="Mentions Légales"
                            bordered={true}
                            style={{ marginBottom: 16, maxWidth: '1000px', borderColor: '#aeaeaecc' }}
                            headStyle={{ borderBottomColor: '#aeaeaecc' }}
                     >
                            <Paragraph>
                                   {`Ce site web est édité par CESI groupe n°4, une société SAS au capital de 100 000 euros, immatriculée au Registre du Commerce et des Sociétés sous le numéro 858210534 et dont le siège social est situé à 390 Rue Claude Nicolas Ledoux
                                   13290 Aix-en-Provence.`}
                            </Paragraph>
                            <Paragraph>
                                   {`Directeur de la publication : Kilian Breton`}
                            </Paragraph>
                            <Paragraph>
                                   {`Contact : kilian.breton1@viacesi.fr`}
                            </Paragraph>
                            <Paragraph>
                                   {`Hébergeur : OVH SAS, 2 rue Kellermann, 59100 Roubaix, France, +33 9 72 10 10 07`}
                            </Paragraph>
                            <Title level={3}>{`Responsabilité`}</Title>
                            <Paragraph>
                                   {`Les informations fournies sur ce site le sont à titre informatif. CESI groupe n°4 ne saurait garantir l'exactitude, la complétude, l'actualité des informations diffusées sur le site. L'utilisateur reconnaît donc utiliser ces informations sous sa responsabilité exclusive.`}
                            </Paragraph>
                            <Title level={3}>{`Propriété intellectuelle`}</Title>
                            <Paragraph>
                                   {`Le contenu du site, incluant, de façon non limitative, les images, les textes, les graphismes, les logos, les icônes, et leur mise en forme sont la propriété exclusive de CESI groupe n°4, à l'exception des marques, logos ou contenus appartenant à d'autres sociétés partenaires ou auteurs.`}
                            </Paragraph>
                            <Title level={3}>{`Liens externes`}</Title>
                            <Paragraph>
                                   {`Ce site peut contenir des liens vers des sites externes qui ne sont pas gérés par CESI groupe n°4. CESI groupe n°4 n'a aucun contrôle sur le contenu et les pratiques de ces sites, et décline toute responsabilité quant à leur contenu ou leurs pratiques.`}
                            </Paragraph>
                            <Title level={3}>{`Cookies`}</Title>
                            <Paragraph>
                                   {`Ce site utilise des cookies pour améliorer l'expérience utilisateur. En utilisant ce site, vous acceptez l'utilisation de cookies conformément à notre politique en matière de cookies.`}
                            </Paragraph>
                            <Title level={3}>{`Politique de confidentialité`}</Title>
                            <Paragraph>
                                   {`Cette politique de confidentialité décrit comment CESI groupe n°4 collecte, utilise et protège les informations que vous nous fournissez lorsque vous utilisez ce site web. En utilisant ce site, vous consentez à la collecte et à l'utilisation de vos informations conformément à cette politique.
                                   Les informations personnelles que nous collectons peuvent inclure votre nom, votre adresse e-mail et d'autres informations nécessaires pour répondre à vos demandes ou pour améliorer votre expérience utilisateur sur le site.`}
                            </Paragraph>

                            <Title level={3}>{`Conditions d'utilisation`}</Title>
                            <Paragraph>
                                   {`En utilisant ce site, vous acceptez de vous conformer à ces conditions d'utilisation. Vous acceptez également de ne pas utiliser ce site à des fins illégales ou interdites par ces termes et conditions. Si vous n'acceptez pas ces conditions, veuillez ne pas utiliser ce site.`}
                            </Paragraph>

                            <Title level={3}>{`Droits d'auteur`}</Title>
                            <Paragraph>
                                   {`Le contenu de ce site, y compris, mais sans s'y limiter, les textes, les images, les graphiques, les logos et les vidéos, est la propriété de CESI groupe n°4 et est protégé par les lois sur le droit d'auteur. Toute utilisation non autorisée du contenu de ce site peut violer les lois sur le droit d'auteur, les marques commerciales et d'autres lois applicables.`}
                            </Paragraph>

                            <Title level={3}>{`Clause de non-responsabilité`}</Title>
                            <Paragraph>
                                   {`Ce site web est fourni "tel quel" sans aucune garantie, expresse ou implicite. CESI groupe n°4 ne fait aucune déclaration et n'offre aucune garantie quant à l'exactitude, l'exhaustivité, la fiabilité, l'actualité ou l'adéquation du contenu de ce site à un usage particulier. En aucun cas, CESI groupe n°4 ne sera responsable des dommages directs, indirects, accessoires, spéciaux, consécutifs ou punitifs résultant de l'utilisation de ce site.`}
                            </Paragraph>
                     </Card>
              </div> 
       );
}
