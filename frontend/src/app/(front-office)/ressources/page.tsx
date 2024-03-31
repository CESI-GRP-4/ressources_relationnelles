// /ressources/page.tsx
"use client"
import React, { useEffect, useState } from 'react';
import { List, Card, Button, Input, Select, Pagination, Typography, PaginationProps } from 'antd';

import axios from 'axios';
import type Resource from "@/types/resource";
import type Category from '@/types/category';

const { Search } = Input;
const { Option } = Select;
const { Title } = Typography;

const DefaultRessources = [
  { id: 0, label: 'Ressource 0', description: 'Description 0', content: 'Contenu 0', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 1, label: 'Ressource 1', description: 'Description 1', content: 'Contenu 1', view_count: BigInt(30), id_category: 1, id_user: 1, creation_date: new Date('2024-03-09') },
  { id: 2, label: 'Ressource 2', description: 'Description 2', content: 'Contenu 2', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 3, label: 'Ressource 3', description: 'Description 3', content: 'Contenu 3', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 4, label: 'Ressource 4', description: 'Description 4', content: 'Contenu 4', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 5, label: 'Ressource 5', description: 'Description 5', content: 'Contenu 5', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 6, label: 'Ressource 6', description: 'Description 6', content: 'Contenu 6', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 7, label: 'Ressource 7', description: 'Description 0', content: 'Contenu 0', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 8, label: 'Ressource 8', description: 'Description 1', content: 'Contenu 1', view_count: BigInt(30), id_category: 1, id_user: 1, creation_date: new Date('2024-03-09') },
  { id: 9, label: 'Ressource 9', description: 'Description 2', content: 'Contenu 2', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 10, label: 'Ressource 10', description: 'Description 3', content: 'Contenu 3', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 11, label: 'Ressource 11', description: 'Description 4', content: 'Contenu 4', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 12, label: 'Ressource 12', description: 'Description 5', content: 'Contenu 5', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 13, label: 'Ressource 13', description: 'Description 6', content: 'Contenu 6', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 14, label: 'Ressource 14', description: 'Description 0', content: 'Contenu 0', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 15, label: 'Ressource 15', description: 'Description 1', content: 'Contenu 1', view_count: BigInt(30), id_category: 1, id_user: 1, creation_date: new Date('2024-03-09') },
  { id: 16, label: 'Ressource 16', description: 'Description 2', content: 'Contenu 2', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 17, label: 'Ressource 17', description: 'Description 3', content: 'Contenu 3', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 18, label: 'Ressource 18', description: 'Description 4', content: 'Contenu 4', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 19, label: 'Ressource 19', description: 'Description 5', content: 'Contenu 5', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
  { id: 20, label: 'Ressource 20', description: 'Description 6', content: 'Contenu 6', view_count: BigInt(20), id_category: 0, id_user: 0, creation_date: new Date() },
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
  const [currentPage, setCurrentPage] = useState<number>(1); // Ajout de l'état pour la pagination
  const [pageSize, setPageSize] = useState<number>(12)

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


  /*Pagination*/

  const startIndex = (currentPage - 1) * pageSize;
  const endIndex = startIndex + pageSize;
  const paginatedRessources = sortedRessources.slice(startIndex, endIndex);

  const handlePageChange = (page: number) => {
    setCurrentPage(page);
  };
  const handlePageSizeChange = (current: number, pageSize: number) => {
    setPageSize(pageSize);
    setCurrentPage(1); // Réinitialiser la page actuelle à 1
  };

  /*---------------*/

  console.log(sortedRessources)
  /*Filtres à corriger (Nom du créateur et Date de création*/
  return (
    <div style={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', marginTop: '2%' }}>
      <Title>Liste des Ressources</Title>
      <div style={{ marginBottom: '16px', marginTop: '1%' }}> {/* Modification de style */}
        <Search placeholder="Rechercher par libellé" onSearch={handleSearch} style={{ width: 450, marginRight: '8px' }} /> {/* Augmentation de la largeur */}
      </div>
      <div style={{ display: 'flex', flexDirection: 'row', marginBottom: '16px' }}> {/* Ajout de marginBottom */}
        <Select placeholder="Trier par" style={{ width: 200 }} onChange={handleSortChange}>
          <Option value={undefined}>Aucun tri</Option>
          <Option value="label">Libellé</Option>
          <Option value="view_count">Nombre de vues</Option>
          <Option value="creator_name">Nom du créateur</Option>
          <Option value="creation_date">Date de création</Option>
          <Option value="category">Catégorie</Option>
        </Select>
        {sortOption === 'view_count' && (
          <Select placeholder="Trier par nombre de vues" style={{ width: 200, marginLeft: '2%', marginRight: '2%' }} onChange={handleOrderChange}>
            <Option value="asc">Croissant</Option>
            <Option value="desc">Décroissant</Option>
          </Select>
        )}
        {sortOption === 'category' && (
          <Select placeholder="Filtrer par catégorie" style={{ width: 200, marginLeft: '2%', marginRight: '2%' }} onChange={handleCategoryChange}>
            <Option value={undefined}>Toutes les catégories</Option>
            {categories.map(category => (
              <Option key={category.id_categorie} value={category.id_categorie}>{category.name}</Option>
            ))}
          </Select>
        )}
        {sortOption === 'creation_date' && (
          <Select placeholder="Filtrer par date de création" style={{ width: 200, marginLeft: '2%', marginRight: '2%' }} onChange={handleCreationDateChange}>
            <Option value={undefined}>Toutes les dates</Option>
            <Option value="oldest">Plus ancienne</Option>
            <Option value="newest">Plus récente</Option>
          </Select>
        )}
      </div>
      <List
        grid={{ gutter: 15, column: 4 }}
        style={{ paddingTop: "2%", paddingLeft: "1%", width: '80%' }}
        dataSource={paginatedRessources}
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
      <Pagination
        style={{ marginTop: '16px' }}
        total={filteredRessources.length}
        showSizeChanger
        showQuickJumper
        pageSizeOptions={['12', '24', '36', '48']}
        defaultPageSize={12}
        pageSize={pageSize} // Mettre à jour la prop pageSize
        onChange={handlePageChange}
        onShowSizeChange={handlePageSizeChange}
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
