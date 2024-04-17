import { Button, Result } from 'antd';

export default function NotFound() {
       return (
              <div className="flex flex-row justify-center items-center h-screen">
                     <Result
                            status="404"
                            title="404"
                            subTitle="Désolé, la page que vous avez visitée n'existe pas."
                            extra={<Button type="primary">{`Retour à l'accueil`}</Button>}
                     />
              </div>
       )
}