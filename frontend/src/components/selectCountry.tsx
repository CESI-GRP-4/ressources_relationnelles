import React, { useState, useEffect } from "react";
import axios, { AxiosError } from "axios";
import { message, Select, Space, Avatar } from "antd";
import Country from "@/types/country";

let globalCountries: Country[] = [];

export const fetchCountries = async () => {
       if (globalCountries.length > 0) {
              return globalCountries; // Return the already fetched countries
       }

       try {
              const response = await axios({
                     method: 'get',
                     baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                     url: '/countries',
                     withCredentials: true,
                     responseType: 'json',
                     timeout: 10000,
              });

              if (response.status === 200) {
                     console.log("response", response.data);
                     globalCountries = response.data.countries; // Store fetched countries in the global array
              }
       } catch (error) {
              const axiosError = error as AxiosError;
              if (axiosError.response) {
                     switch (axiosError.response.status) {
                            case 400:
                                   message.error('Requête invalide');
                                   break;
                            case 401:
                                   message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                   break;
                            case 403:
                                   message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                   break;
                            case 404:
                                   message.error(`Ressource non trouvée`);
                                   break;
                            case 422:
                                   message.error('Champs manquants ou invalides');
                                   break;
                            default:
                                   message.error(`Erreur inconnue`);
                                   break;
                     }
              } else {
                     message.error('Erreur réseau ou serveur indisponible');
              }
       }
       finally {
              return globalCountries;
       }
};

function SelectCountry({ value, onChange }: { value: any, onChange: any }) {
       const [countries, setCountries] = useState<Country[]>([]);

       useEffect(() => {
              fetchCountries().then(fetchedCountries => {
                     if (fetchedCountries) {
                            setCountries(fetchedCountries);
                     } else {
                            setCountries([]);
                     }
              });
       }, []);

       return (
              <Select
                     size='large'
                     showSearch
                     value={value}
                     onChange={onChange}
                     optionFilterProp="children"
                     filterOption={(input, option) => {
                            return (option?.value?.toString() ?? '').toLowerCase().indexOf(input.toLowerCase()) >= 0;
                     }}
              >
                     {countries.map(country => (
                            <Select.Option key={country.code} value={country.name}>
                                   <Space>
                                          <Avatar src={`https://flagcdn.com/h240/${country.code.toLowerCase()}.png`} />
                                          <span>{country.name}</span>
                                   </Space>
                            </Select.Option>
                     ))}
              </Select>
       );
}

export default SelectCountry;
