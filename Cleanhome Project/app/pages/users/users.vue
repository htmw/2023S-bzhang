<template>
	<view>
		<u-navbar title="ShopList" :border="true" :placeholder="true" @leftClick="goBack"  :autoBack="false"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<imgList :imgSize="2" imgName="img" titleName="username" @clickItem='userDetail' :dataList='fobjList' sName='tel' ></imgList>
		</scroll-view>
	</view>
</template>

<script>
	import { listj, findj, savej, deletej, fileUrl } from '@/common/config/api.js';
	import {mapState, mapActions} from 'vuex';
	import imgList from '@/components/img-list.vue';
	
	export default {
		components:{imgList},
		data() {
			return {
				fobjList:[]
			};
		},
		onLoad(params) {
			listj({params: {table: 'user',roletype:'3'}}).then(res => {
				this.fobjList = res
			}).catch(err => {
			 
			})
		},
		methods: {
			
			userGoods(sid){
				uni.navigateTo({
					url: '/pages/good/goodview?sid='+sid
				})
			},
			userDetail(pid){
				uni.navigateTo({
					url: '/pages/users/userdetail?pid='+pid
				})
			},
			goBack(){
				uni.switchTab({
					url:'/pages/index/index'
				})
			}
		},
		computed: {
			...mapState(['userInfo'])
		}
	}
</script>

<style lang="scss">

</style>
