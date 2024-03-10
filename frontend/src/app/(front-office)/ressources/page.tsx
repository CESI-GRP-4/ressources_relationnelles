// /ressources/page.tsx
"use client"
import React, { useEffect, useState } from 'react';
import { List, Card, Button, Input, Select } from 'antd';
import axios from 'axios';
import type Resource from "@/types/resource";
import type Category from '@/types/category';

const { Search } = Input;
const { Option } = Select;

const DefaultRessources = [
  { id: 0, label: 'Ressource 0', description: 'Description 0', content: 'Contenu 0', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 1, label: 'Ressource 1', description: 'Description 1', content: 'Contenu 1', view_count: BigInt(30), id_category: 1, id_user: 1, creation_date: new Date('2024-03-09') }
];

const DefaultCategories = [
  { id_categorie: 0, name: "Categorie 0" },
  { id_categorie: 1, name: "Categorie 1" }
];

const DefaultUsers = [
  { id_user: 0, first_name: "John", last_name: "Doe" },
  { id_user: 1, first_name: "Jordan", last_name: "Davis" }
];

export default function RessourcesPage() {
  const [ressources, setRessources] = useState<Resource[]>([]);
  const [categories, setCategories] = useState<Category[]>([]);
  const [searchText, setSearchText] = useState<string>('');
  const [selectedCategory, setSelectedCategory] = useState<number | undefined>(undefined);
  const [creatorSearch, setCreatorSearch] = useState<string>('');
  const [creationDate, setCreationDate] = useState<string | undefined>(undefined);
  const [viewCount, setViewCount] = useState<number | undefined>(undefined);
  const [sortOption, setSortOption] = useState<string | undefined>(undefined);
  const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('asc');

  useEffect(() => {
    const fetchData = async () => {
      try {
        const responseRessources = await axios.get('http://localhost/api/getRessources');
        const responseCategories = await axios.get('http://localhost/api/getCategories');

        setRessources(responseRessources.data);
        setCategories(responseCategories.data);
      } catch (error) {
        console.error("Erreur lors de la récupération des données:", error);
        setRessources(DefaultRessources);
        setCategories(DefaultCategories);
      }
    };

    fetchData();
  }, []);

  // Ajoutez cette fonction pour comparer les dates
  function compareCreationDate(creationDate: Date, filterOption: string | undefined): boolean {
    if (!filterOption || filterOption === 'all') {
      return true;
    }

    const today = new Date().getTime();
    const ressourceDate = creationDate.getTime();

    if (filterOption === 'oldest') {
      return ressourceDate < today;
    } else if (filterOption === 'newest') {
      return ressourceDate >= today;
    }

    return true;
  }

  // Modifiez ensuite votre fonction filteredRessources comme suit
  const filteredRessources = ressources.filter(ressource => {
    const matchText = (
      ressource.label.toLowerCase().includes(searchText.toLowerCase()) ||
      ressource.description.toLowerCase().includes(searchText.toLowerCase()) ||
      ressource.content.toLowerCase().includes(searchText.toLowerCase())
    );
    const matchCategory = selectedCategory === undefined || selectedCategory === null || ressource.id_category === selectedCategory;
    const matchCreatorName =
      creatorSearch === '' ||
      (sortOption === 'creator_name' &&
        (getFullName(ressource.id_user).toLowerCase().includes(creatorSearch.toLowerCase()) ||
          `${getFullName(ressource.id_user)} ${getFullName(ressource.id_user)}`
            .toLowerCase()
            .includes(creatorSearch.toLowerCase())));

    const matchCreationDate = compareCreationDate(ressource.creation_date, sortOption);

    const matchViewCount = viewCount === undefined || ressource.view_count === BigInt(viewCount);

    return matchText && matchCategory && matchCreatorName && matchCreationDate && matchViewCount;
  });

  const sortedRessources = filteredRessources.sort((a, b) => {
    if (!sortOption) return 0; // No sorting

    const orderModifier = sortOrder === 'asc' ? 1 : -1;

    switch (sortOption) {
      case 'label':
        return orderModifier * a.label.localeCompare(b.label);
      case 'view_count':
        return orderModifier * (Number(a.view_count) - Number(b.view_count));
      case 'creator_name':
        return orderModifier * getFullName(a.id_user).localeCompare(getFullName(b.id_user));
      case 'creation_date':
        return orderModifier * (a.creation_date.getTime() - b.creation_date.getTime());
      case 'category':
        return orderModifier * getCategoryName(a.id_category).localeCompare(getCategoryName(b.id_category));
      // Ajoutez d'autres cas pour d'autres options de tri au besoin
      default:
        return 0; // No sorting
    }
  });

  const handleSearch = (value: string) => {
    setSearchText(value);
    setSelectedCategory(undefined);
  };

  const handleCategoryChange = (value: number) => {
    setSelectedCategory(value);
  };

  const handleCreatorSearch = (value: string) => {
    setCreatorSearch(value);
  };

  const handleSortChange = (value: string) => {
    setSortOption(value);
    setSelectedCategory(undefined);
    setSortOrder('asc');
  };

  const handleOrderChange = () => {
    setSortOrder((prevOrder) => (prevOrder === 'asc' ? 'desc' : 'asc'));
  };

  const handleCreationDateChange = (value: string) => {
    setCreationDate(value);
  };

  return (
    <div>
      <h1>Liste des Ressources</h1>
      <h3>Filtres à corriger (Nom du créateur et Date de création)</h3>
      <div style={{ marginBottom: '16px' }}>
        <Search placeholder="Rechercher par libellé" onSearch={handleSearch} style={{ width: 200, marginRight: '8px' }} />

        {sortOption === 'view_count' && (
          <Select placeholder="Trier par nombre de vues" style={{ width: 200 }} onChange={handleOrderChange}>
            <Option value="asc">Croissant</Option>
            <Option value="desc">Décroissant</Option>
          </Select>
        )}

        {sortOption === 'category' && (
          <Select placeholder="Filtrer par catégorie" style={{ width: 200 }} onChange={handleCategoryChange}>
            <Option value={undefined}>Toutes les catégories</Option>
            {categories.map(category => (
              <Option key={category.id_categorie} value={category.id_categorie}>{category.name}</Option>
            ))}
          </Select>
        )}

        {sortOption === 'creation_date' && (
          <Select placeholder="Filtrer par date de création" style={{ width: 200 }} onChange={handleCreationDateChange}>
            <Option value={undefined}>Toutes les dates</Option>
            <Option value="oldest">Plus ancienne</Option>
            <Option value="newest">Plus récente</Option>
          </Select>
        )}

        <Select placeholder="Trier par" style={{ width: 200 }} onChange={handleSortChange}>
          <Option value={undefined}>Aucun tri</Option>
          <Option value="label">Libellé</Option>
          <Option value="view_count">Nombre de vues</Option>
          <Option value="creator_name">Nom du créateur</Option>
          <Option value="creation_date">Date de création</Option>
          <Option value="category">Catégorie</Option>
        </Select>
      </div>
      <List
        grid={{ gutter: 10, column: 6 }}
        style={{ paddingTop: "2%", paddingLeft: "1%" }}
        dataSource={sortedRessources}
        renderItem={(ressource: Resource) => (
          <List.Item>
            <Card title={ressource.label}>
              <p>Description: {ressource.description}</p>
              <p>Contenu: {ressource.content}</p>
              <p>Nombre de vues: {ressource.view_count.toString()}</p>
              <p>Catégorie: {getCategoryName(ressource.id_category)}</p>
              <p>Nom du créateur: {getFullName(ressource.id_user)}</p>
              <p>Date de création: {formatDate(ressource.creation_date)}</p>
              <Button
                style={{ marginTop: "5%" }}
              >Voir la ressource</Button>
            </Card>
          </List.Item>
        )}
      />
    </div>
  );

  function formatDate(date: Date): string {
    const options: Intl.DateTimeFormatOptions = { year: 'numeric', month: 'long', day: 'numeric' };
    return date.toLocaleDateString('fr-FR', options);
  }

  function getFullName(userId: number): string {
    const user = DefaultUsers.find(u => u.id_user === userId);
    return user ? `${user.first_name} ${user.last_name}` : '';
  }

  function getCategoryName(categoryId: number): string {
    const category = categories.find(cat => cat.id_categorie === categoryId);
    return category ? category.name : 'Catégorie inconnue';
  }
}
