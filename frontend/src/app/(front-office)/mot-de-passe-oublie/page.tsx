// /mot-de-passe-oublie/page.tsx

export default function MotDePasseOublie() {
       return (
              <div>
                     <h1>Mot de passe oublié</h1>
                     <p>Entrez votre adresse email pour recevoir un lien de réinitialisation de votre mot de passe.</p>
                     <form>
                            <input type="email" placeholder="Email" />
                            <button type="submit">Envoyer</button>
                     </form>
              </div>
       );
}