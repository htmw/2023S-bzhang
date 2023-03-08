
<template>
	<view>
		<u-navbar title="my message" :border="true" :placeholder="true"   :autoBack="true"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<imgList :round="true" imgName="img" :sType="2" :imgSize="1"  :fx="false" titleName="fusername" tName="note" @clickItem="toChatFriend" :dataList="fobjlist"></imgList>
		</scroll-view>
	</view>
</template>

<script>
	import {
		listj,
		listSqlj,
		findj,
		savej,
		deletej,
		fileUrl
	} from '@/common/config/api.js';
	import {
		mapState,
		mapActions
	} from 'vuex';
	import ideaList from '@/components/idea-list/idea-list.vue';
	import imgList from '@/components/img-list.vue';
	import { ideautil, yewuutil } from '@/common/commontools.js';
	export default {
		components:{ ideaList, imgList },
		data() {
			return {
				fileUrl: fileUrl,
				fobjlist: []
			};
		},
		onShow() {
			this.refresh()
		},
		methods: {
			...mapActions(['updateUserInfo']),
			toChat:yewuutil.toChat,
			userDetail(tid) {
				uni.redirectTo({
					url: '/pages/qunzu/userdetail?id=' + tid
				})
			},
			refresh(){
				listj({params: {table: "huihua", uid: this.userInfo.id }}).then(rl => {
					this.fobjlist = rl || []
				}).catch(err => {
				 
				})
			},
			goBack() {
				uni.navigateBack({
					delta: 1
				})
			},
			toChatFriend(id){
				findj({params: {table: 'huihua', id: id}}).then(res => {
					if (res) {
						this.toChat(res.fid)
					}
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
