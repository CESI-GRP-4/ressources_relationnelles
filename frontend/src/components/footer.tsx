import { Layout, Avatar, Tooltip } from "antd"
import Image from "next/image"
import logo from "/public/logo.png"
import TristanR from "/public/TristanR.jpeg"
import NicolasC from "/public/NicolasC.jpeg"
import KilianB from "/public/KilianB.jpeg"
import ArthurC from "/public/ArthurC.jpeg"
import React from "react";
const { Footer: AntdFooter } = Layout

export default function Footer() {
       return (
              <AntdFooter className="!bg-white">
                     {/* <Header collapsed={collapsed} setCollapsed={setCollapsed}/> */}
                     <div className="flex flex-col items-center">
                            <Image
                                   className='m-2 rounded-lg'
                                   src={logo}
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
                                                        <Avatar alt="Photo de Tristan Roos" draggable={false} src={<Image alt={"Photo de Tristan Roos"} src={TristanR} width={32} height={32}></Image>} />
                                                 </a>
                                          </Tooltip>
                                          <Tooltip title="Nicolas Chwiej" placement="top">
                                                 <a href="https://github.com/Capryc0rne" target="_blank">
                                                        <Avatar alt="Photo de Nicolas Chwiej" draggable={false} src={<Image alt={"Photo de Nicolas Chwiej"} src={NicolasC} width={32} height={32}></Image>} />
                                                 </a>
                                          </Tooltip>
                                          <Tooltip title="Kilian Breton" placement="top">
                                                 <a href="https://github.com/KilianBre" target="_blank">
                                                        <Avatar alt="Photo de Kilian Breton" draggable={false} src={<Image alt={"Photo de Kilian Breton"} src={KilianB} width={32} height={32}></Image>}/>
                                                 </a>
                                          </Tooltip>
                                          <Tooltip title="Arthur Crahé" placement="top">
                                                 <a href="https://github.com/khylpe" target="_blank">
                                                        <Avatar alt="Photo de Arthur Crahé" draggable={false} src={<Image alt={"Photo de Arthur Crahé"} src={ArthurC} width={32} height={32}></Image>} />
                                                 </a>
                                          </Tooltip>
                                   </Avatar.Group>
                            </div>
                     </div>
              </AntdFooter>
       )
}