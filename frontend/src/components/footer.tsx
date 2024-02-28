import { Layout } from "antd"
const { Footer: AntdFooter } = Layout

export default function Footer() {
       return (
              <AntdFooter style={{ textAlign: 'center' }}>{`(RE)Sources Relationnelles`}</AntdFooter>
       )
}