"use client"
import { Button, Card, Typography } from "antd";
import { Icon } from '@iconify/react';
import { Category } from "@/types/category";
import { useState, useEffect } from "react";
import axios from 'axios';

const { Paragraph } = Typography;

export default function CategoryPage({ params }: { params: {id: string} }) {
    const [resources, setResources] = useState<any[]>([]);
    const [isLoading, setIsLoading] = useState<boolean>(false);

    useEffect(()=>{
        fetchResources();
    }, [])

    const fetchResources = async () => {
        try {
            setIsLoading(true);
            const response = await axios({
                method: 'GET',
                baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                url: `/category/${params.id}`,
                responseType: 'json',
                timeout: 10000,
                withCredentials: true,
            });
            setResources(response.data.category.ressources);
        } catch (error) {
            console.error("Error fetching resources:", error);
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <>
           
            {resources.length > 0 && (
                <div>
                    {/* <h3>Ressources liées à {category.title} :</h3> */}
                    {isLoading ? (
                        <p>Loading...</p>
                    ) : (
                        <ul>
                            {resources.map((resource, index) => (
                                <li key={index}>{resource.label}</li> 
                            ))}
                        </ul>
                    )}
                </div>
            )}
        </>
    );
}