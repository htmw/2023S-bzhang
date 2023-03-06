<template>
	<view>
		<u-navbar title="管理订单" :border="true" @leftClick="goBack" :placeholder="true"  :autoBack="false"></u-navbar>
		
		<scroll-view :enable-flex="true" class="svcontainer">
			<u-tabs :list="typelist" keyName="title" @change="onTabChange"></u-tabs>
			<imgList @clickItem="fobjDetail" :dataList="fobjlist" :imgSize="20" titleName="ndate" sName="gnames" tName="statecn" ></imgList>
			<!-- <u-list>
				<u-list-item v-for="(item,index) in fobjlist">
					<u-cell :name="item.id" @click="fobjDetail" :value="item.statecn" :title="item.ndate" :label="item.gnames" isLink />
				</u-list-item>
			</u-list> -->
		</scroll-view>
	</view>
</template>

<script>
	import { listj, findj, savej, deletej, fileUrl } from '@/common/config/api.js'
	import {mapState, mapActions} from 'vuex'
	import imgList from '@/components/img-list.vue'
	
	
	export default {
		components:{ imgList },
		data() {
			return {
				fobjlist:[],
				tabtitle: null,
				typelist: [{title: 'paid'},
				{title: 'Received'},

				{title: 'completed'},
					{title: 'evaluated'}]
			};
		},
		onLoad(params) {
			listj({params: {table: 'bill',sid:this.userInfo.id}}).then(res => {
				this.fobjlist = res
			}).catch(err => {
			 
			})
		},
		onShow() {
			this.refreshBill()
		},
		methods: {
			...mapActions(['updateUserInfo']),
			onTabChange (item){
				this.tabtitle = null
				/* if(item.title != 'ALL'){ */
					if (item.title=='待接单') {
						this.tabtitle = '待处理'
					}else{
						this.tabtitle = item.title
					}
					
				//}
				this.refreshBill()
			},
			refreshBill (){
				let qid = null
				if (this.tabtitle != '待处理') {
					qid = this.userInfo.id
				}
				listj({params: {table: 'bill', statecn: this.tabtitle,sid:qid}}).then(res => {
					this.fobjlist = res
				}).catch(err => {
				 
				})
			},
			fobjDetail (bid){
				uni.navigateTo({
					url: '/pages/bill/billdetailqs?bid='+bid
				})
			},
			goBack() {
				uni.switchTab({
					url:'/pages/me/me'
				})
			},
		},
		computed: {
			...mapState(['userInfo'])
		}
	}
</script>

<style lang="scss">

</style>
