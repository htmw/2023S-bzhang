<template>
	<view>
		<u-navbar title="Housekeeping Details" :border="true" :placeholder="true"   :autoBack="true"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<image v-if="fobj.img" class="showimg" :src="fileUrl+fobj.img" mode="widthFix"></image>
			<view class="formitem">
				<view class="gprice">price:{{fobj.price}}</view>
			</view>
			<view class="formitem">
				<view class="gtitle">{{fobj.gname}}</view>
			</view>
			
			<u-parse :content="fobj.note" />
			<view class="hpaddingctn">
				<button @click="toChat" type="default">Customer service</button>
			</view>
			
			<imgList :showArrow='false' :showSearch="false"  :dataList="replaylist" :imgSize="20" titleName="ndate" sName="note" tName="username" ></imgList>
			
		
			<view class="hpaddingctn" v-show="showpl">
				<tn-rate v-model="pingfen" :size="54"></tn-rate>
			</view>
		
			<view class="hpaddingctn" v-show="showpl">
				<tn-input v-model="rnote" type="textarea" :border="true" :height="100" :autoHeight="true" />
			</view>
			
			<view class="hpaddingctn" v-show="showpl">
				<tn-button @click="replay()" backgroundColor="tn-bg-blue" fontColor="#FFFFFF" width="100%">submit reviews
				</tn-button>
			</view>
			
			
			<view class="footerctn">
				<navigator url="#" class="gmbtn" @click="goumai()">order</navigator>

				<navigator url="#" class="scbtn" @click="toggleFav()">{{favtext}}</navigator>
			</view>
			
			<tn-tips
			  ref="tips"
			></tn-tips>
		</scroll-view>
	</view>
</template>

<script>
	import { savej, listj, findj, fileUrl } from '@/common/config/api.js'
	import {mapState, mapActions} from 'vuex'
	import { ideautil, yewuutil } from '@/common/commontools.js'
	import imgList from '@/components/img-list.vue'
	export default {
		components:{ imgList  },
		data() {
			return {
				gid: null,
				fileUrl: fileUrl,
				favtext: "add to fav",
				fobj: {},
				replaylist: [],
				rnote: '',
				pingfen:0,
				showpl:false
			};
		},
		onLoad(params) {
			this.gid = params.gid
			if (params.showpl==1) {
				this.showpl = true
			}
			this.fobjDetail()
		},
		methods: {
			...mapActions(['setCar']),
			fobjDetail() {
				findj({params: {table: 'good', id: this.gid}}).then(res => {
					this.fobj = res
					this.fobj.note = ideautil.getHtmlNote(this.fobj.note)
					this.checkFavs()
					this.listReplay()
					this.putHistory()
				}).catch(err => {
					
				})
			},
			putHistory(){
				let id = this.gid
				let hgids = uni.getStorageSync("his_ids")
				if(hgids){
					let flag = ideautil.checkStrInStr(id,hgids)
					if (!flag) {
						hgids += ","+id
					}
				}else{
					hgids = id
				}
				uni.setStorageSync("his_ids",hgids)
			},
			goumai() {
				getApp().globalData.fobj = this.fobj
				uni.navigateTo({
					url:'/pages/bill/surebill'
				})
				/*this.fobj.count = 1
				this.fobj.checked = true
				this.carlist.push(this.fobj)
				uni.switchTab({
					url:'../shopcar/shopcar'
				})*/
			},
			toggleFav() {
				let myfavs = this.userInfo.favs
				console.log("favs:"+myfavs)
				if (this.favtext == "add to fav") {
					if (myfavs && myfavs != '0') {
						myfavs += ","+this.fobj.id
					}else{
						myfavs = this.fobj.id+""
					}
				}else {
					myfavs = ideautil.removeStrInStr(this.fobj.id, myfavs) || "0"
				}
				
				savej({ params: { table: "user", favs: myfavs, id: this.userInfo.id } }).then(res => {
					this.userInfo.favs = myfavs
					this.checkFavs()
				}).catch(err => {
					
				})
			},
			checkFavs() {
				this.favtext = "add to fav"
				let myfavs = this.userInfo.favs
				let isfav = ideautil.checkStrInStr(this.fobj.id+"",myfavs)
				if (isfav) {
					this.favtext = "remove fav"
				}
			},
			addCar() {
				let clist = this.carlist
				if (clist && clist.length) {
					let gid = this.fobj.id
					let flag = false
					for (let i = 0; i < clist.length; i++) {
						let cgood = clist[i]
						if (gid == cgood.id) {
							cgood.count+=1
							flag = true
							break
						}
					}
					
					
					if (flag === false) {
						this.fobj.count = 1
						this.fobj.checked = true
						clist.push(this.fobj)
					}else{
						//?????????????????????????????????????????????
						clist = clist.splice(0)
					}
				} else{
					this.fobj.count = 1
					this.fobj.checked = true
					clist.push(this.fobj)
				}
				//this.carlist = clist
				this.setCar(clist)
				uni.showToast({
					icon:'none',
					title: 'Successful operation!'
				})
			},
			showCar(){
				uni.switchTab({
					url:'/pages/shopcar/shopcar'
				})
			},
			goBack(){
				uni.navigateBack({
					delta:1
				})
			},
			toChat(){
				findj({params: {table: 'user', id: this.fobj.sid}}).then(res => {
					if (res) {
						let shopuser = res
						uni.redirectTo({
							url:'../chati/chati?fid='+shopuser.id
						})
					}else{
						uni.showToast({
							icon:'none',
							title: 'No online customer service!'
						})
					}
					
				}).catch(err => {
				 
				})
				
			},
			listReplay(){
				listj({params: {table: 'replay', pid: this.fobj.id, type: 1}}).then(res => {
					this.replaylist = res
				}).catch(err => {
				 
				})
			},
			replay(){
				if(this.rnote){
					let fdata = {
						table:"replay",
						pid: this.fobj.id,
						note: this.rnote,
						uid: this.userInfo.id,
						username: this.userInfo.username,
						type: 1
					}
					savej({params: fdata}).then(res => {
						this.listReplay()
						this.showpl = false
						this.$refs.tips.show({
						  msg: 'Successful operation!'
						})
					}).catch(err => {
					 
					})
				}
			}
		},
		computed: {
			...mapState(['carlist', 'userInfo'])
		}
	}
</script>

<style lang="scss">
	
	.gprice{
		font-size: 26upx;
		color:red;
	}
	.gtitle{
		font-size: 26upx;
		padding: 10upx 0;
	}
	
	
	.gmbtn{
		flex: 1;
		text-align: center;
		background-color: #e45656;
		color: #fff;
		height: 100%;
		line-height: 100upx;
	}
	.carbtn{
		flex: 1;
		text-align: center;
		background-color: #18b566;
		color: #fff;
		height: 100%;
		line-height: 100upx;
	}
	.scbtn{
		flex: 1;
		text-align: center;
		background-color: #fb8b05;
		color: #fff;
		height: 100%;
		line-height: 100upx;
	}
	.showcarbtn{
		flex: 1;
		text-align: center;
		background-color: #3c9cff;
		color: #fff;
		height: 100%;
		line-height: 100upx;
	}
	
	.showimg{
		width: 100%;
	}
</style>
