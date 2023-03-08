<template>
	<view>
		<!-- <uni-nav-bar statusBar="true" fixed="true" title="Home" shadow></uni-nav-bar> -->
		<u-navbar title="Home" leftIconSize="0" :border="true" :placeholder="true"  :autoBack="true"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<swiper :circular="true" :indicator-dots="true" :autoplay="true" :interval="3000" :duration="1000">
				<swiper-item @click="toNotice" v-for="(item,index) in noticelist">
					<image class="swiperimg" :src="fileUrl+item.img"></image>
				</swiper-item>
			</swiper>
			<view class="gridmenu">
				
				<view class="gridmenuitem" @click="toShops">
					<image class="gridmenuicon" src="http://124.71.39.108/static/images/icons2/dingdan.png"></image>
					<text class="gridmenutitle">Shop</text>
				</view>

				<view class="gridmenuitem" @click="toPosts()">
					<image class="gridmenuicon" src="http://124.71.39.108/static/images/icons2/shoucang.png"></image>
					<text class="gridmenutitle">Feedback</text>
				</view>
			</view>
			
			<u-tabs :list="typelist" keyName="title" @change="refreshGood"></u-tabs>
			<imglist imgName="img" sName="type" tName="price" tLabel="price:" imgSize="pubu" titleName="gname" :dataList="fobjList" @clickItem="toGoodDetail"></imglist>
		</scroll-view>
	</view>
</template>

<script>
	import { listj, findj, fileUrl } from '@/common/config/api.js'
	import { ideautil, yewuutil } from '@/common/commontools.js'
	import {mapState, mapActions} from 'vuex'
	
	
	export default {
		data() {
			return {
				title: 'Home',
				noticelist: [],
				searchstr:'',
				fileUrl: fileUrl,
				fobjList: [],
				typelist: []
			}
		},
		onLoad() {
			let username = this.userInfo && this.userInfo.username
			let passwd = this.userInfo && this.userInfo.passwd
			let openid = this.userInfo && this.userInfo.openid
			
			console.log(`username:${username} passwd ${passwd} openid ${openid}`)
			
			if (openid) {
				findj({params: {table: 'user', openid: openid}}).then(res => {
					if (res) {
						this.updateUserInfo(res)
					} else {
						this.updateUserInfo({})
						yewuutil.toLogin()
					}
				}).catch(err => {
					yewuutil.toLogin()
				})
			}else if (username && passwd) {
				findj({
					params: {
						table: 'user',
						username,
						passwd
					}
				}).then(res => {
					console.log(res)
					if (res) {
						this.updateUserInfo(res)
					} else {
						this.updateUserInfo({})
						yewuutil.toLogin()
					}
				}).catch(err => {
					yewuutil.toLogin()
				})
			}else{
				yewuutil.toLogin()
			}
			
			
			listj({params: {table: 'notice'}}).then(res => {
				if (res.length && res.length > 5) {
					this.noticelist = res.slice(0,5)
				} else{
					this.noticelist = res
				}
				
			}).catch(err => {
				
			})
			listj({params: {table: 'good'}}).then(res => {
				this.fobjList = res
			}).catch(err => {
				
			})
			
			listj({params: {table: 'type'}}).then(res => {
				this.typelist = res || []
				this.typelist.unshift({id:0,title:"ALL"})
			}).catch(err => {
				
			})
		},
		methods: {
			...mapActions(['updateUserInfo', 'logout']),
			async listBlog(){
				let fobjList = await list({params: {table: 'blog'}});
				this.fobjList = fobjList;
			},
			toGoodDetail:yewuutil.toGoodDetail,
			toAddress: yewuutil.toAddress,
			toMyBill: yewuutil.toMyBill,
			toMyFavs: yewuutil.toMyFavs,
			toShops: yewuutil.toShops,
			toIndex2(){
				uni.navigateTo({
					url:'/pages/index/indexfenlei'
				})
			},
			refreshGood(index){
				console.log(index);
				let typeid = null
				if(index){
					typeid = index.id==0?null:index.id
				}
				
				listj({params: {table: 'good', gname: this.searchstr,typeid: typeid}}).then(res => {
					this.fobjList = res
				})
			},
			/* toGoodDetail(gid){
				uni.navigateTo({
					url:"../good/gooddetail?gid="+gid
				})
			}, */
			toNotice(){
				uni.navigateTo({
					url:"/pages/notice/notice"
				})
			},
			toBillShop(){
				uni.navigateTo({
					url:"/pages/bill/billshop"
				})
			},
			toBillqs(){
				uni.navigateTo({
					url:"/pages/bill/billqs"
				})
			},
			toDitui(){
				uni.navigateTo({
					url:'/pages/ditui/ditui'
				})
			},
			toPosts(){
				uni.navigateTo({
					url:'/pages/posts/posts'
				})
			},
			toBrand(){
				uni.navigateTo({
					url:'/pages/brand/brand'
				})
			},
			toGoodNew(){
				uni.navigateTo({
					url:'/pages/good/goodview?stype=新品'
				})
			},
			toGoodSale(){
				uni.navigateTo({
					url:'/pages/good/goodview?stype=热销'
				})
			},
			toGoodTejia(){
				uni.navigateTo({
					url:'/pages/good/goodview?stype=特价'
				})
			}
		},
		watch: {
			searchstr(v){
				console.log(v);
				uni.$u.debounce(this.refreshGood, 500, false)
			}
		},
		computed: {
			...mapState(['userInfo'])
		}
	}
</script>

<style>
	
	.swiperimg{
		width: 100%;
	}
	
	.mainsearch{
		margin-top: 10upx;
	}
</style>
