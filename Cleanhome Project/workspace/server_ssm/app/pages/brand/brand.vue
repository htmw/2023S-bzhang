<template>
	<view>
		<u-navbar title="brand List" :border="true" :placeholder="true" @leftClick="goBack"  :autoBack="false"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<gridMenu @clickItem='brandGoods' :dataList='fobjList'></gridMenu>
		</scroll-view>
	</view>
</template>

<script>
	import { listj, findj, savej, deletej, fileUrl } from '@/common/config/api.js';
	import {mapState, mapActions} from 'vuex';
	import gridMenu from '@/components/grid-menu.vue';
	
	export default {
		components:{gridMenu},
		data() {
			return {
				fobjList:[],
				fileUrl:fileUrl
			};
		},
		onLoad(params) {
			listj({params: {table: 'brand'}}).then(res => {
				this.fobjList = res
			}).catch(err => {
			 
			})
		},
		methods: {
			goBack(){
				uni.ytool.toIndex()
			},
			brandGoods(id){
				uni.navigateTo({
					url: '/pages/brand/brandgoods?ppid='+id
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
