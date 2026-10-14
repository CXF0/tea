<script setup lang="ts">
import { appConfig } from '@/app/config/env'
import { ref } from 'vue'
import { coldStorageApi } from '../api/cold-storage.api'
const props=withDefaults(defineProps<{modelValue:string[];max?:number}>(),{max:3})
const emit=defineEmits<{ 'update:modelValue':[value:string[]] }>()
const uploading=ref(false)
async function choose(){if(uploading.value||props.modelValue.length>=props.max)return;uni.chooseImage({count:props.max-props.modelValue.length,sourceType:['camera','album'],success:async result=>{uploading.value=true;try{const next=[...props.modelValue];for(const path of result.tempFilePaths)next.push((await coldStorageApi.uploadImage(path)).url);emit('update:modelValue',next)}catch(e){uni.showToast({title:e instanceof Error?e.message:'照片上传失败',icon:'none'})}finally{uploading.value=false}}})}
function remove(index:number){emit('update:modelValue',props.modelValue.filter((_,i)=>i!==index))}
const src=(value:string)=>value.startsWith('http')?value:`${appConfig.apiBaseUrl.replace(/\/api\/?$/,'')}${value}`
</script>
<template><view><view class="images"><view v-for="(url,index) in modelValue" :key="url" class="image"><image :src="src(url)" mode="aspectFill"/><text @click="remove(index)">×</text></view><view v-if="modelValue.length<max" class="add" @click="choose"><strong>＋</strong><text>{{uploading?'上传中':'添加照片'}}</text></view></view><small>必填，最多 {{max}} 张</small></view></template>
<style scoped>.images{display:grid;grid-template-columns:repeat(3,1fr);gap:12rpx}.image,.add{position:relative;height:170rpx;overflow:hidden;border-radius:15rpx}.image image{width:100%;height:100%}.image>text{position:absolute;top:7rpx;right:7rpx;display:flex;width:38rpx;height:38rpx;align-items:center;justify-content:center;border-radius:50%;background:rgba(23,43,41,.72);color:#fff;font-size:28rpx}.add{display:flex;align-items:center;justify-content:center;flex-direction:column;border:2rpx dashed #b8ceca;background:var(--wms-page);color:var(--wms-text-secondary);font-size:19rpx}.add strong{color:var(--wms-primary-700);font-size:38rpx}small{display:block;margin-top:10rpx;color:var(--wms-text-secondary);font-size:18rpx}</style>
