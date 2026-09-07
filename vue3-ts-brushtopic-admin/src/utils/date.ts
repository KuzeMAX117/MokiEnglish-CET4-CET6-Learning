import dayjs from "dayjs";
import * as echarts from 'echarts';

export function addDateRange(params: any, dateRange: any, propName: string) {
  const search = params;
  search['begin' + propName] = dayjs(dateRange[0]).format('YYYY-MM-DD');
  search['end' + propName] = dayjs(dateRange[1]).format('YYYY-MM-DD');
  return search;
}

export function clearDateRange(params: any, propName: string) {
  const search = params;
  search['begin' + propName] = '';
  search['end' + propName] = '';
  return search;
}

export function getVirtulDataByYear(year: number) {
  const { start, end } = getYearDateRange(year);
  const dayTime = 3600 * 24 * 1000;
  const data = [];
  for (let time = start; time <= end; time += dayTime) {
    data.push([
      echarts.format.formatTime('yyyy-MM-dd', time),
      Math.floor(Math.random() * 5)
    ]);
  }
  return data;
}

export function getYearDateRange(year: number) {
  const startDate = new Date(year, 0, 1); 
  const endDate = new Date(year, 11, 31); 
  return {
    start: startDate.getTime(),
    end: endDate.getTime(),
    startStr: echarts.format.formatTime('yyyy-MM-dd', startDate),
    endStr: echarts.format.formatTime('yyyy-MM-dd', endDate)
  };
}

export function isLeapYear(year: number) {
  return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
}

export function getDynamicDateRange() {
  const today = new Date();

  
  const startDate = new Date(today);
  startDate.setFullYear(today.getFullYear() - 1);

  
  const endDate = new Date(today);

  
  if (
    startDate.getMonth() === 1 &&
    startDate.getDate() === 29 &&
    !isLeapYear(startDate.getFullYear())
  ) {
    startDate.setDate(28);
  }

  return {
    start: startDate.getTime(),
    end: endDate.getTime(),
    startStr: echarts.format.formatTime('yyyy-MM-dd', startDate),
    endStr: echarts.format.formatTime('yyyy-MM-dd', endDate)
  };
}