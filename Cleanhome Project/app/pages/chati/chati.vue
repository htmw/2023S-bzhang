<template>
	<view>
		<u-navbar title="聊天" :border="true" :placeholder="true" @leftClick="goBack()" :autoBack="false"></u-navbar>
		<view :enable-flex="true" class="svcontainer">
			<web-view :src="chaturl"></web-view>
		</view>
	</view>
</template>

<script>
	import { listj, findj, savej, deletej, fileUrl, staticUrl } from '@/common/config/api.js';
	import {mapState, mapActions} from 'vuex'
	export default {
		data() {
			return {
				chaturl: '',
				staticUrl: staticUrl
			};
		},
		onLoad(params) {
			let fid = params.fid
			let chattype = params.type || 1
			this.chaturl = this.staticUrl+'client/chati.html?uid='+this.userInfo.id+'&fid='+fid+'&action=chat&chattype='+chattype
		},
		methods: {
			...mapActions(['updateUserInfo']),

			goBack(){
				uni.switchTab({
					url:'/pages/me/me'
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
