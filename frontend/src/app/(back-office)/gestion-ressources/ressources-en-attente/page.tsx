"use client"
import axios, { AxiosError } from "axios"
import { useEffect } from "react"
import { message } from "antd"

export default function PendingRessources() {


       useEffect(() => {
              fetchPendingRessources()
       }, [])

       const fetchPendingRessources = async () => {
              try {
                     const response = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressources/pending`)
                     console.log(response.data)
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403 || 401:
                                          message.error("Vous n'êtes pas autorisé")
                                          break
                                   default:
                                          message.error("Erreur lors de la récupération des catégories")
                            }
                     } else {
                            message.error("Erreur lors de la récupération des catégories")
                     }
              }
       }
       return (
              <div>
                     <h1>Ressources en attente</h1>
              </div>
       )
}