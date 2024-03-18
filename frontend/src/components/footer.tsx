import { Layout, Avatar, Tooltip } from "antd"
import Image from "next/image"
const { Footer: AntdFooter } = Layout

export default function Footer() {
       return (
              <AntdFooter className="!bg-white">
                     {/* <Header collapsed={collapsed} setCollapsed={setCollapsed}/> */}
                     <div className="flex flex-col items-center">
                            <Image
                                   className='m-2 rounded-lg'
                                   src="/logo.png"
                                   alt="Logo du ministère des solidarités et de la santé"
                                   width={140}
                                   height={160}
                                   draggable={false}
                            />
                            <p>{`© 2024 (RE)Sources Relationnelles.`}</p>
                            <p>Ministère des solidarités et de la santé</p>

                            <div className="mt-6 flex flex-row items-center">
                                   <Tooltip title="CESI Aix-en-Provence | Groupe n°4" placement="top">
                                          <Image
                                                 draggable={false}
                                                 className='m-2 rounded-lg'
                                                 src="https://upload.wikimedia.org/wikipedia/fr/thumb/e/ef/Logo_cesi_2022.png/240px-Logo_cesi_2022.png"
                                                 alt="Logo du CESI"
                                                 width={60}
                                                 height={60}
                                          />
                                   </Tooltip>
                                   <Avatar.Group>
                                          <Tooltip title="Tristan Roos" placement="top">
                                                 <a href="https://github.com/Tristan13R" target="_blank">
                                                        <Avatar alt="Photo de Tristan Roos" draggable={false} src="https://media.licdn.com/dms/image/D4D03AQHok1gjkCcz0A/profile-displayphoto-shrink_400_400/0/1683907687734?e=1714608000&v=beta&t=2QOnvgDGveQb-JA-fECjvSPj9IQRoYhSeeIA1FA2GbE" />
                                                 </a>
                                          </Tooltip>
                                          <Tooltip title="Nicolas Chwiej" placement="top">
                                                 <a href="https://github.com/Capryc0rne" target="_blank">
                                                        <Avatar alt="Photo de Nicolas Chwiej" draggable={false} src="https://media.licdn.com/dms/image/C4E03AQEDd1CWgoEOzA/profile-displayphoto-shrink_200_200/0/1642267651204?e=1714608000&v=beta&t=ZzZjKjYTksPtV7e7rjFEahxNE5DaCJ8k1YFC1iDBENw"/>
                                                 </a>
                                          </Tooltip>
                                          <Tooltip title="Kilian Breton" placement="top">
                                                 <a href="https://github.com/KilianBre" target="_blank">
                                                        <Avatar alt="Photo de Kilian Breton" draggable={false} src="https://media.licdn.com/dms/image/C4E03AQGmDAiuCikMxw/profile-displayphoto-shrink_200_200/0/1660986972543?e=1714608000&v=beta&t=N-0q_XMByd0xeyBNRAaeWqazh1Ixgp7oEC4r_wECvZ4"/>
                                                 </a>
                                          </Tooltip>
                                          <Tooltip title="Arthur Crahé" placement="top">
                                                 <a href="https://github.com/khylpe" target="_blank">
                                                        <Avatar alt="Photo de Arthur Crahé" draggable={false} src="https://github.com/khylpe.png" />
                                                 </a>
                                          </Tooltip>
                                   </Avatar.Group>
                            </div>
                     </div>
              </AntdFooter>
       )
}