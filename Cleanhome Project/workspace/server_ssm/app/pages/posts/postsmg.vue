<template>
	<view>
		<u-navbar title="message management" :border="true" :placeholder="true"   :autoBack="true"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<view class="formitem">
				<view class="formlabel">title:</view>
				<input type="text" v-model="fobj.title" class="binput1" />
			</view>
			<view class="formitem">
				<view class="formlabel">document:</view>
				<fileUpload v-model="sfileName"></fileUpload>
			</view>
			<view class="formitem">
				<view class="formlabel">details:</view>
				<view style="border: 1px #ddd solid;">
					<jinEdit :html="editorHtml" @getEditorContxt="getEditorContxt" v-model="fobj.note" height="300px" :uploadFileUrl="uploadUrl" placeholder="Please enter content" @editOk="editOk"></jinEdit>
				</view>
			</view>
			
			
			<view class="formitem">
				<button type="primary" @click="savePosts()">submit</button>
			</view>
			<view class="formitem" v-if="tid">
				<button type="warn" @click="delPosts()">delete</button>
			</view>

		</scroll-view>
	</view>
</template>

<script>
	import {
		listj,
		findj,
		savej,
		deletej,
		fileUrl,
		uploadUrl
	} from '@/common/config/api.js';
	import {
		mapState,
		mapActions
	} from 'vuex';
	import jinEdit from '@/components/jin-edit/jin-edit.vue';
	import ideaUpload from '@/components/idea-upload/idea-upload.vue';
	import fileUpload from '@/components/file-upload.vue';
	import { ideautil, yewuutil } from '@/common/commontools.js'
	export default {
		components: {
			jinEdit,
			fileUpload,
			ideaUpload
		},
		data() {
			return {
				tel: '',
				typelist: [],
				filelist: [],
				fobj: {
					title: '',
					type: 1,
					note: '',
					img: '',
					table: 'posts'
				},
				tid: null,
				fileUrl: fileUrl,
				uploadUrl: uploadUrl,
				editorCtx:null,
				editorHtml:'',
				totype:1
			};
		},
		onLoad(params) {
			if (params.tid && params.tid !== 'undefined') {
				this.tid = params.tid
			}
			this.totype = params.totype || 1
			console.log('tttttttid:' + params.tid + " showdel:" + this.showdel)
			if (this.tid) {
				findj({
					params: {
						table: 'posts',
						id: this.tid
					}
				}).then(res => {
					this.fobj = res
					this.filelist.push({url: this.fileUrl + res.img})
					console.log(this.imgfile)
					this.editorHtml = this.fobj.note
					/* this.editorCtx.setContents({
						html: this.fobj.note
					}) */
					
				}).catch(err => {

				})
			}
			
			listj({
				params: {
					table: 'type2'
				}
			}).then(res => {
				this.typelist = res
			}).catch(err => {
			
			})
		},
		methods: {
		
			//...mapActions(['']),
			
			savePosts() {
				this.editorCtx.getContents({
					success: res => {
						this.fobj.note = res.html
						this.fobj.uid = this.userInfo.id
						this.fobj.username = this.userInfo.username
						console.log(this.filelist)
						 
						this.filelist.length?this.fobj.img = this.filelist[0].url.data:this.fobj.img=""
						let fdata = this.fobj
						fdata.table = "posts"
						savej({
							params: fdata
						}).then(res => {
							if (this.totype==1) {
								uni.redirectTo({
									url: './posts?type='+this.fobj.type+'&uid='+this.userInfo.id
								})
							}else{
								uni.redirectTo({
									url: './postslist?type='+this.fobj.type+'&uid='+this.userInfo.id
								})
							}
							
						}).catch(err => {
						
						})
					} 
				})
				
			},
			comboboxselect(e){
				this.fobj.typeid = e.id
				this.fobj.type = e.title
			},
			delPosts() {
				deletej({
					params: {
						table: 'posts',
						id: this.tid
					}
				}).then(res => {
					uni.redirectTo({
						url: './posts'
					})
				}).catch(err => {

				})
			},
			goBack() {
				uni.navigateBack({
					delta: 1
				})
			},
			
			editOk(res) {
				this.fobj.note = res.html
			},
			getEditorContxt(ctx){
				this.editorCtx = ctx
				this.editorCtx.setContents({
					html: this.fobj.note
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
