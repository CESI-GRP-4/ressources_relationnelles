// ForgotPasswordLink component
import Link from "next/link"

export default function ForgotPasswordLink() {
       return (
              <div className='text-center'>
                     <Link className='underline decoration-2 text-lg underline-offset-2' href="/mot-de-passe-oublie">{`J'ai oublié mon mot de passe`}</Link>
              </div>
       )
}