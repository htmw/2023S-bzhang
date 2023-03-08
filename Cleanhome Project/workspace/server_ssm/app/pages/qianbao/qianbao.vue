<template>
	<view>
		<u-navbar title="My purse" :border="true" :placeholder="true"   :autoBack="true"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<view class="toplogo">
				<image src="https://www.svgrepo.com/show/262820/wallet.svg" mode="widthFix"></image>
			</view>
			<view>
				<view class="yetitle">my balance</view>
				<view class="yecontent">${{userInfo.money||0}}</view>
			</view>
			<view class="hpaddingctn">
				<u-button type="primary" text="recharge" @click="toCharge" />
			</view>
		</scroll-view>
	</view>
</template>

<script>
	import { listj, findj, savej, fileUrl, saveWxUser, uploadUrl } from '@/common/config/api.js'
	import {mapState, mapActions} from 'vuex'
	import ideaUpload from '@/components/idea-upload/idea-upload.vue'
	import { serverUrl } from '@/common/config/api.js'
	export default {
		components: {ideaUpload},
		data() {
			return {

			}
		},
		onLoad() {
			
		},
		methods: {
			...mapActions(['updateUserInfo']),
			toCharge(){
				uni.navigateTo({
					url:'/pages/qianbao/charge'
				})
			}
		},
		computed: {
			...mapState(['userInfo'])
		}
	}
</script>

<style lang="scss">
	.toplogo{
		text-align: center;
	}
	.toplogo image{
		width: 20%;
		margin-top: 100rpx;
	}
	.yetitle{
		text-align: center;
		font-size: 30rpx;
		padding: 20rpx;
	}
	.yecontent{
		text-align: center;
		font-size: 80rpx;
		padding: 40rpx;
	}
</style>
