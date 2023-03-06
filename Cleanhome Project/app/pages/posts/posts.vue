<template>
	<view>
		<u-navbar title="帖子List" :border="true" :placeholder="true" rightText="新增" @rightClick="postsMg()" @leftClick="goBack"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<imgList :imgSize="20" titleName="title" @clickItem='toPostsDetail' :dataList="fobjList" tName="username" sName='ndate' ></imgList>
		</scroll-view>
	</view>
</template>

<script>
	import { listSqlj, listj, findj, savej, fileUrl } from '@/common/config/api.js';
	import {mapState, mapActions} from 'vuex';
	import imgList from '@/components/img-list.vue';
	import blogList from '@/components/blog-list.vue';
	import { ideautil, yewuutil } from '@/common/commontools.js';
	export default {
		data() {
			return {
				fobjList: [],
				ftype:1
			};
		},
		components:{imgList, blogList},
		onLoad(params) {
			this.ftype = params.type || 1
			//let sql = `select b.*,(select count(pid) from wct_replay r where r.pid=b.id) pinglun,u.img uimg from wct_posts b left join wct_user u on u.id=b.uid where 1=1`
			listj({params: {table: "posts", type: this.ftype}}).then(res => {
				this.fobjList = res
			}).catch(err => {
			 
			})
		},
		onShow() {
			
		},
		methods: {
			...mapActions(['updateUserInfo']),
			toPostsDetail(id){
				uni.redirectTo({
					url:'/pages/posts/postsdetail?id='+id
				})
			},
			postsMg(id){
				console.log("------------------>:aid:"+id)
				uni.redirectTo({
					url:'./postsmg?totype=1&tid='+id
				})
			},
			
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