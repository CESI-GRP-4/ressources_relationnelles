import { Button, Result } from 'antd';
import Link from 'next/link';

export default function NotFound() {
       return (
              <div className="flex flex-row justify-center items-center h-screen">
                     <Result
                            status="404"
                            title="404"
                            subTitle="Désolé, la page que vous avez visitée n'existe pas."
                            extra={<Link href="/"><Button type="primary">{`Retour à l'accueil`}</Button></Link>}
                     />
              </div>
       )
}