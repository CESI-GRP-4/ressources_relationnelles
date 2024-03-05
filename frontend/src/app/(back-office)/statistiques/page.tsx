"use client"

import React from 'react';
import { DatePicker } from 'antd';
import dayjs, { Dayjs } from 'dayjs';
import TestChart from "@/components/testChart";

const { RangePicker } = DatePicker;

// Définir le type de retour de la fonction comme étant boolean
const disabledDate = (current: Dayjs | null): boolean => {
       // Ne peut pas sélectionner de jours après aujourd'hui
       return !!current && current.isAfter(dayjs().endOf('day'));
};

export default function Statistiques() {
       const dateFormat = 'DD/MM/YYYY';

       return (
              <>
                     <div>
                            <RangePicker
                                   format={dateFormat}
                                   disabledDate={disabledDate}
                            />
                            <TestChart></TestChart>
                     </div>
              </>
       );
}
