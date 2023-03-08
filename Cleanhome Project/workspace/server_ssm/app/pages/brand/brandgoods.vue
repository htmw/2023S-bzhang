<template>
	<view>
		<u-navbar title="brand housekeeping" :border="true" :placeholder="true" :autoBack="true"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<imgList :imgSize="10" imgName="img" titleName="gname" @clickItem='toGoodDetail' :dataList='fobjList' sName='shop' tName="price"></imgList>
		</scroll-view>
	</view>
</template>

<script>
	import { listj, findj, savej, deletej, fileUrl } from '@/common/config/api.js';
	import {mapState, mapActions} from 'vuex';
	import { ideautil, yewuutil } from '@/common/commontools.js';
	import imgList from '@/components/img-list.vue';
	export default {
		data() {
			return {
				fobjList:[]
			};
		},
		onLoad(params) {
			let ppid = params.ppid
			listj({params: {table: 'good', ppid: ppid }}).then(res => {
				this.fobjList = res
			}).catch(err => {
			 
			})
		},
		methods: {
			toGoodDetail:yewuutil.toGoodDetail,
			goBack(){
				uni.navigateBack({
					delta:1
				})
			}
		},
		computed: {
			...mapState(['userInfo'])
		},
		components:{imgList}
	}
</script>

<style lang="scss">

</style>
