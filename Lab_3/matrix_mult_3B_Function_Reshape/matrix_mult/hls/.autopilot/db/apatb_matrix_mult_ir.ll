; ModuleID = 'D:/SOCD334264/Lab_3/matrix_mult_3B_Function_Reshape/matrix_mult/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: inaccessiblememonly nounwind willreturn
declare void @llvm.sideeffect() #0

; Function Attrs: inaccessiblemem_or_argmemonly noinline willreturn
define void @apatb_matrix_mult_ir([5 x i8]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="5" %a, [5 x i8]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="5" %b, [5 x i16]* noalias nocapture nonnull "fpga.decayed.dim.hint"="5" %prod) local_unnamed_addr #1 {
entry:
  %0 = bitcast [5 x i8]* %a to [5 x [5 x i8]]*
  %a_copy1 = alloca [5 x i40], align 512
  %1 = getelementptr [5 x i40], [5 x i40]* %a_copy1, i64 0, i64 0
  %2 = bitcast [5 x i8]* %b to [5 x [5 x i8]]*
  %b_copy2 = alloca [5 x i40], align 512
  %3 = bitcast [5 x i16]* %prod to [5 x [5 x i16]]*
  %prod_copy = alloca [5 x [5 x i16]], align 512
  call void @copy_in([5 x [5 x i8]]* nonnull %0, [5 x i40]* nonnull align 512 %a_copy1, [5 x [5 x i8]]* nonnull %2, [5 x i40]* nonnull align 512 %b_copy2, [5 x [5 x i16]]* nonnull %3, [5 x [5 x i16]]* nonnull align 512 %prod_copy)
  call void @llvm.sideeffect() #7 [ "xlx_array_reshape"(i40* %1, i32 998, i32 1, i32 0) ], !dbg !6
  call void @llvm.sideeffect() #7 [ "xlx_array_reshape"([5 x i40]* %b_copy2, i32 998, i32 1, i32 0) ], !dbg !377
  call void @apatb_matrix_mult_hw([5 x i40]* %a_copy1, [5 x i40]* %b_copy2, [5 x [5 x i16]]* %prod_copy)
  call void @copy_back([5 x [5 x i8]]* %0, [5 x i40]* %a_copy1, [5 x [5 x i8]]* %2, [5 x i40]* %b_copy2, [5 x [5 x i16]]* %3, [5 x [5 x i16]]* %prod_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8([5 x [5 x i8]]* "orig.arg.no"="0" %dst, [5 x [5 x i8]]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %src, null
  %1 = icmp eq [5 x [5 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i8([5 x i8]* %dst.addr, [5 x i8]* %src.addr, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8([5 x i8]* "orig.arg.no"="0" %dst, [5 x i8]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x i8]* %src, null
  %1 = icmp eq [5 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x i8], [5 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x i8], [5 x i8]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i8, i8* %src.addr, align 1
  store i8 %3, i8* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a5a5i16([5 x [5 x i16]]* noalias align 512 %dst, [5 x [5 x i16]]* noalias readonly %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x [5 x i16]]* %dst, null
  %1 = icmp eq [5 x [5 x i16]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i16([5 x [5 x i16]]* nonnull %dst, [5 x [5 x i16]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i16([5 x [5 x i16]]* %dst, [5 x [5 x i16]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x [5 x i16]]* %src, null
  %1 = icmp eq [5 x [5 x i16]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [5 x i16]], [5 x [5 x i16]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x [5 x i16]], [5 x [5 x i16]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i16([5 x i16]* %dst.addr, [5 x i16]* %src.addr, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i16([5 x i16]* %dst, [5 x i16]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x i16]* %src, null
  %1 = icmp eq [5 x i16]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x i16], [5 x i16]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x i16], [5 x i16]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i16, i16* %src.addr, align 2
  store i16 %3, i16* %dst.addr, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8.5.6(i40* "orig.arg.no"="0" %dst, i64 %dst_shift, [5 x i8]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i8]* %src, null
  %1 = icmp eq i40* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = mul i64 8, %for.loop.idx2
  %4 = add i64 %dst_shift, %3
  %src.addr = getelementptr [5 x i8], [5 x i8]* %src, i64 0, i64 %for.loop.idx2
  %5 = load i8, i8* %src.addr, align 1
  %6 = load i40, i40* %dst, align 8
  %7 = trunc i64 %4 to i40
  %8 = shl i40 255, %7
  %9 = zext i8 %5 to i40
  %10 = shl i40 %9, %7
  %thr.xor1 = xor i40 %8, -1
  %thr.and2 = and i40 %6, %thr.xor1
  %thr.or3 = or i40 %10, %thr.and2
  store i40 %thr.or3, i40* %dst, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8.4.7([5 x i40]* "orig.arg.no"="0" %dst, i64 %dst_shift, [5 x [5 x i8]]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %src, null
  %1 = icmp eq [5 x i40]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr1 = getelementptr [5 x i40], [5 x i40]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i8.5.6(i40* %dst.addr1, i64 %dst_shift, [5 x i8]* %src.addr, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a5a5i8.3.8([5 x i40]* noalias align 512 "orig.arg.no"="0" %dst, [5 x [5 x i8]]* noalias readonly "orig.arg.no"="1" %src) #3 {
entry:
  %0 = icmp eq [5 x i40]* %dst, null
  %1 = icmp eq [5 x [5 x i8]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i8.4.7([5 x i40]* nonnull %dst, i64 0, [5 x [5 x i8]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8.11.12([5 x i40]* "orig.arg.no"="0" %dst, i64 %dst_shift, [5 x i8]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i8]* %src, null
  %1 = icmp eq [5 x i40]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  %3 = trunc i64 %dst_shift to i40
  %4 = shl i40 255, %3
  %5 = xor i40 %4, -1
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr1 = getelementptr [5 x i40], [5 x i40]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x i8], [5 x i8]* %src, i64 0, i64 %for.loop.idx2
  %6 = load i8, i8* %src.addr, align 1
  %7 = load i40, i40* %dst.addr1, align 8
  %8 = zext i8 %6 to i40
  %9 = shl i40 %8, %3
  %10 = and i40 %7, %5
  %11 = or i40 %10, %9
  store i40 %11, i40* %dst.addr1, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8.10.13([5 x i40]* "orig.arg.no"="0" %dst, i64 %dst_shift, [5 x [5 x i8]]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %src, null
  %1 = icmp eq [5 x i40]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = mul i64 8, %for.loop.idx2
  %4 = add i64 %dst_shift, %3
  %src.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i8.11.12([5 x i40]* %dst, i64 %4, [5 x i8]* %src.addr, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a5a5i8.9.14([5 x i40]* noalias align 512 "orig.arg.no"="0" %dst, [5 x [5 x i8]]* noalias readonly "orig.arg.no"="1" %src) #3 {
entry:
  %0 = icmp eq [5 x i40]* %dst, null
  %1 = icmp eq [5 x [5 x i8]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i8.10.13([5 x i40]* nonnull %dst, i64 0, [5 x [5 x i8]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in([5 x [5 x i8]]* noalias readonly "orig.arg.no"="0", [5 x i40]* noalias align 512 "orig.arg.no"="1", [5 x [5 x i8]]* noalias readonly "orig.arg.no"="2", [5 x i40]* noalias align 512 "orig.arg.no"="3", [5 x [5 x i16]]* noalias readonly "orig.arg.no"="4", [5 x [5 x i16]]* noalias align 512 "orig.arg.no"="5") #4 {
entry:
  call void @onebyonecpy_hls.p0a5a5i8.3.8([5 x i40]* align 512 %1, [5 x [5 x i8]]* %0)
  call void @onebyonecpy_hls.p0a5a5i8.9.14([5 x i40]* align 512 %3, [5 x [5 x i8]]* %2)
  call fastcc void @onebyonecpy_hls.p0a5a5i16([5 x [5 x i16]]* align 512 %5, [5 x [5 x i16]]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8.21.22([5 x i8]* "orig.arg.no"="0" %dst, i40* readonly "orig.arg.no"="1" %src, i64 %src_shift, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i40* %src, null
  %1 = icmp eq [5 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x i8], [5 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %3 = mul i64 8, %for.loop.idx2
  %4 = add i64 %src_shift, %3
  %5 = load i40, i40* %src, align 8
  %6 = trunc i64 %4 to i40
  %7 = lshr i40 %5, %6
  %8 = trunc i40 %7 to i8
  store i8 %8, i8* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8.20.23([5 x [5 x i8]]* "orig.arg.no"="0" %dst, [5 x i40]* readonly "orig.arg.no"="1" %src, i64 %src_shift, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i40]* %src, null
  %1 = icmp eq [5 x [5 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr1 = getelementptr [5 x i40], [5 x i40]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i8.21.22([5 x i8]* %dst.addr, i40* %src.addr1, i64 %src_shift, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a5a5i8.19.24([5 x [5 x i8]]* noalias "orig.arg.no"="0" %dst, [5 x i40]* noalias readonly align 512 "orig.arg.no"="1" %src) #3 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %dst, null
  %1 = icmp eq [5 x i40]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i8.20.23([5 x [5 x i8]]* nonnull %dst, [5 x i40]* nonnull %src, i64 0, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8.27.28([5 x i8]* "orig.arg.no"="0" %dst, [5 x i40]* readonly "orig.arg.no"="1" %src, i64 %src_shift, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i40]* %src, null
  %1 = icmp eq [5 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  %3 = trunc i64 %src_shift to i40
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x i8], [5 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr1 = getelementptr [5 x i40], [5 x i40]* %src, i64 0, i64 %for.loop.idx2
  %4 = load i40, i40* %src.addr1, align 8
  %5 = lshr i40 %4, %3
  %6 = trunc i40 %5 to i8
  store i8 %6, i8* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8.26.29([5 x [5 x i8]]* "orig.arg.no"="0" %dst, [5 x i40]* readonly "orig.arg.no"="1" %src, i64 %src_shift, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i40]* %src, null
  %1 = icmp eq [5 x [5 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = mul i64 8, %for.loop.idx2
  %4 = add i64 %src_shift, %3
  call void @arraycpy_hls.p0a5i8.27.28([5 x i8]* %dst.addr, [5 x i40]* %src, i64 %4, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a5a5i8.25.30([5 x [5 x i8]]* noalias "orig.arg.no"="0" %dst, [5 x i40]* noalias readonly align 512 "orig.arg.no"="1" %src) #3 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %dst, null
  %1 = icmp eq [5 x i40]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i8.26.29([5 x [5 x i8]]* nonnull %dst, [5 x i40]* nonnull %src, i64 0, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out([5 x [5 x i8]]* noalias "orig.arg.no"="0", [5 x i40]* noalias readonly align 512 "orig.arg.no"="1", [5 x [5 x i8]]* noalias "orig.arg.no"="2", [5 x i40]* noalias readonly align 512 "orig.arg.no"="3", [5 x [5 x i16]]* noalias "orig.arg.no"="4", [5 x [5 x i16]]* noalias readonly align 512 "orig.arg.no"="5") #5 {
entry:
  call void @onebyonecpy_hls.p0a5a5i8.19.24([5 x [5 x i8]]* %0, [5 x i40]* align 512 %1)
  call void @onebyonecpy_hls.p0a5a5i8.25.30([5 x [5 x i8]]* %2, [5 x i40]* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a5a5i16([5 x [5 x i16]]* %4, [5 x [5 x i16]]* align 512 %5)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare void @apatb_matrix_mult_hw([5 x i40]* %a, [5 x i40]* %b, [5 x [5 x i16]]* %prod)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back([5 x [5 x i8]]* noalias "orig.arg.no"="0", [5 x i40]* noalias readonly align 512 "orig.arg.no"="1", [5 x [5 x i8]]* noalias "orig.arg.no"="2", [5 x i40]* noalias readonly align 512 "orig.arg.no"="3", [5 x [5 x i16]]* noalias "orig.arg.no"="4", [5 x [5 x i16]]* noalias readonly align 512 "orig.arg.no"="5") #5 {
entry:
  call fastcc void @onebyonecpy_hls.p0a5a5i16([5 x [5 x i16]]* %4, [5 x [5 x i16]]* align 512 %5)
  ret void
}

declare void @matrix_mult_hw_stub([5 x i8]* noalias nocapture nonnull readonly, [5 x i8]* noalias nocapture nonnull readonly, [5 x i16]* noalias nocapture nonnull)

define void @matrix_mult_hw_stub_wrapper([5 x i40]* %a, [5 x i40]* %b, [5 x [5 x i16]]* %prod) #6 {
entry:
  %0 = call i8* @malloc(i64 25)
  %1 = bitcast i8* %0 to [5 x [5 x i8]]*
  %2 = call i8* @malloc(i64 25)
  %3 = bitcast i8* %2 to [5 x [5 x i8]]*
  call void @copy_out([5 x [5 x i8]]* %1, [5 x i40]* %a, [5 x [5 x i8]]* %3, [5 x i40]* %b, [5 x [5 x i16]]* null, [5 x [5 x i16]]* %prod)
  %4 = bitcast [5 x [5 x i8]]* %1 to [5 x i8]*
  %5 = bitcast [5 x [5 x i8]]* %3 to [5 x i8]*
  %6 = bitcast [5 x [5 x i16]]* %prod to [5 x i16]*
  call void @matrix_mult_hw_stub([5 x i8]* %4, [5 x i8]* %5, [5 x i16]* %6)
  call void @copy_in([5 x [5 x i8]]* %1, [5 x i40]* %a, [5 x [5 x i8]]* %3, [5 x i40]* %b, [5 x [5 x i16]]* null, [5 x [5 x i16]]* %prod)
  call void @free(i8* %0)
  call void @free(i8* %2)
  ret void
}

attributes #0 = { inaccessiblememonly nounwind willreturn }
attributes #1 = { inaccessiblemem_or_argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #5 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #6 = { "fpga.wrapper.func"="stub" }
attributes #7 = { inaccessiblememonly nounwind willreturn "xlx.source"="infer-from-pragma" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1}
!llvm.module.flags = !{!2, !3, !4}
!blackbox_cfg = !{!5}

!0 = !{!"AMD/Xilinx clang version 16.0.6"}
!1 = !{!"clang version 7.0.0 "}
!2 = !{i32 2, !"Dwarf Version", i32 4}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{}
!6 = !DILocation(line: 8, column: 1, scope: !7)
!7 = distinct !DISubprogram(name: "matrix_mult", linkageName: "_Z11matrix_multPA5_cS0_PA5_s", scope: !8, file: !8, line: 3, type: !9, isLocal: false, isDefinition: true, scopeLine: 7, flags: DIFlagPrototyped, isOptimized: false, unit: !25, variables: !5)
!8 = !DIFile(filename: "../source/tut3B_Function_Reshape/matrix_mult.cpp", directory: "D:\5CSOCD334264\5CLab_3\5Cmatrix_mult_3B_Function_Reshape")
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11, !18, !21}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 40, elements: !16)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "mat_a", file: !14, line: 15, baseType: !15)
!14 = !DIFile(filename: "../source/tut3B_Function_Reshape/matrix_mult.h", directory: "D:\5CSOCD334264\5CLab_3\5Cmatrix_mult_3B_Function_Reshape")
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !{!17}
!17 = !DISubrange(count: 5)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 40, elements: !16)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "mat_b", file: !14, line: 16, baseType: !15)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 80, elements: !16)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "mat_prod", file: !14, line: 17, baseType: !24)
!24 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!25 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !26, producer: "AMD/Xilinx clang version 16.0.6", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, imports: !27, splitDebugInlining: false, gnuPubnames: true)
!26 = !DIFile(filename: "D:/SOCD334264/Lab_3/matrix_mult_3B_Function_Reshape/matrix_mult/hls/.autopilot/db\5Cmatrix_mult.pp.0.cpp", directory: "D:\5CSOCD334264\5CLab_3\5Cmatrix_mult_3B_Function_Reshape", checksumkind: CSK_MD5, checksum: "fe68485bcc95ffc3e8b55325a8d96fa5")
!27 = !{!28, !36, !42, !44, !46, !50, !52, !54, !56, !58, !60, !62, !64, !69, !73, !75, !77, !82, !84, !86, !88, !90, !92, !94, !96, !99, !101, !105, !110, !112, !114, !116, !118, !120, !122, !124, !126, !128, !130, !134, !138, !140, !142, !144, !146, !148, !150, !152, !154, !156, !158, !160, !162, !164, !166, !168, !172, !176, !180, !182, !184, !186, !188, !190, !192, !194, !196, !198, !202, !206, !210, !212, !214, !216, !221, !225, !229, !231, !233, !235, !237, !239, !241, !243, !245, !247, !249, !251, !253, !258, !262, !266, !268, !270, !272, !278, !282, !286, !288, !290, !292, !294, !296, !298, !302, !306, !308, !310, !312, !314, !318, !322, !326, !328, !330, !332, !334, !336, !338, !342, !346, !350, !352, !356, !360, !362, !364, !366, !368, !370, !372, !376}
!28 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !30, file: !35, line: 52)
!29 = !DINamespace(name: "std", scope: null)
!30 = !DISubprogram(name: "abs", scope: !31, file: !31, line: 254, type: !32, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!31 = !DIFile(filename: "C:/AMDDesignTools/2026.1/Vitis/tps/mingw/8.3.0/win64.o/nt\5Cx86_64-w64-mingw32\5Cinclude\5Cmath.h", directory: "")
!32 = !DISubroutineType(types: !33)
!33 = !{!34, !34}
!34 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!35 = !DIFile(filename: "C:/AMDDesignTools/2026.1/Vitis/tps/mingw/8.3.0/win64.o/nt\5Clib\5Cgcc\5Cx86_64-w64-mingw32\5C8.3.0\5Cinclude\5Cc++\5Cbits/std_abs.h", directory: "")
!36 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !37, file: !41, line: 83)
!37 = !DISubprogram(name: "acos", scope: !31, file: !31, line: 190, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!38 = !DISubroutineType(types: !39)
!39 = !{!40, !40}
!40 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!41 = !DIFile(filename: "C:/AMDDesignTools/2026.1/Vitis/tps/mingw/8.3.0/win64.o/nt\5Clib\5Cgcc\5Cx86_64-w64-mingw32\5C8.3.0\5Cinclude\5Cc++\5Ccmath", directory: "")
!42 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !43, file: !41, line: 102)
!43 = !DISubprogram(name: "asin", scope: !31, file: !31, line: 189, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!44 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !45, file: !41, line: 121)
!45 = !DISubprogram(name: "atan", scope: !31, file: !31, line: 191, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!46 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !47, file: !41, line: 140)
!47 = !DISubprogram(name: "atan2", scope: !31, file: !31, line: 192, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!48 = !DISubroutineType(types: !49)
!49 = !{!40, !40, !40}
!50 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !51, file: !41, line: 161)
!51 = !DISubprogram(name: "ceil", scope: !31, file: !31, line: 198, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!52 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !53, file: !41, line: 180)
!53 = !DISubprogram(name: "cos", scope: !31, file: !31, line: 184, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!54 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !55, file: !41, line: 199)
!55 = !DISubprogram(name: "cosh", scope: !31, file: !31, line: 187, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!56 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !57, file: !41, line: 218)
!57 = !DISubprogram(name: "exp", scope: !31, file: !31, line: 193, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!58 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !59, file: !41, line: 237)
!59 = !DISubprogram(name: "fabs", scope: !31, file: !31, line: 204, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!60 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !61, file: !41, line: 256)
!61 = !DISubprogram(name: "floor", scope: !31, file: !31, line: 199, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!62 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !63, file: !41, line: 275)
!63 = !DISubprogram(name: "fmod", scope: !31, file: !31, line: 246, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!64 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !65, file: !41, line: 296)
!65 = !DISubprogram(name: "frexp", scope: !31, file: !31, line: 244, type: !66, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!66 = !DISubroutineType(types: !67)
!67 = !{!40, !40, !68}
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!69 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !70, file: !41, line: 315)
!70 = !DISubprogram(name: "ldexp", scope: !31, file: !31, line: 243, type: !71, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!71 = !DISubroutineType(types: !72)
!72 = !{!40, !40, !34}
!73 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !74, file: !41, line: 334)
!74 = !DISubprogram(name: "log", scope: !31, file: !31, line: 194, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!75 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !76, file: !41, line: 353)
!76 = !DISubprogram(name: "log10", scope: !31, file: !31, line: 195, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!77 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !78, file: !41, line: 372)
!78 = !DISubprogram(name: "modf", scope: !31, file: !31, line: 245, type: !79, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!79 = !DISubroutineType(types: !80)
!80 = !{!40, !40, !81}
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!82 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !83, file: !41, line: 384)
!83 = !DISubprogram(name: "pow", scope: !31, file: !31, line: 196, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!84 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !85, file: !41, line: 421)
!85 = !DISubprogram(name: "sin", scope: !31, file: !31, line: 183, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!86 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !87, file: !41, line: 440)
!87 = !DISubprogram(name: "sinh", scope: !31, file: !31, line: 186, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!88 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !89, file: !41, line: 459)
!89 = !DISubprogram(name: "sqrt", scope: !31, file: !31, line: 197, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!90 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !91, file: !41, line: 478)
!91 = !DISubprogram(name: "tan", scope: !31, file: !31, line: 185, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!92 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !93, file: !41, line: 497)
!93 = !DISubprogram(name: "tanh", scope: !31, file: !31, line: 188, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!94 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !95, file: !41, line: 1065)
!95 = !DIDerivedType(tag: DW_TAG_typedef, name: "double_t", file: !31, line: 373, baseType: !40)
!96 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !97, file: !41, line: 1066)
!97 = !DIDerivedType(tag: DW_TAG_typedef, name: "float_t", file: !31, line: 372, baseType: !98)
!98 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!99 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !100, file: !41, line: 1069)
!100 = !DISubprogram(name: "acosh", scope: !31, file: !31, line: 705, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!101 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !102, file: !41, line: 1070)
!102 = !DISubprogram(name: "acoshf", scope: !31, file: !31, line: 706, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!103 = !DISubroutineType(types: !104)
!104 = !{!98, !98}
!105 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !106, file: !41, line: 1071)
!106 = !DISubprogram(name: "acoshl", scope: !31, file: !31, line: 707, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!107 = !DISubroutineType(types: !108)
!108 = !{!109, !109}
!109 = !DIBasicType(name: "long double", size: 64, encoding: DW_ATE_float)
!110 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !111, file: !41, line: 1073)
!111 = !DISubprogram(name: "asinh", scope: !31, file: !31, line: 710, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!112 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !113, file: !41, line: 1074)
!113 = !DISubprogram(name: "asinhf", scope: !31, file: !31, line: 711, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!114 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !115, file: !41, line: 1075)
!115 = !DISubprogram(name: "asinhl", scope: !31, file: !31, line: 712, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!116 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !117, file: !41, line: 1077)
!117 = !DISubprogram(name: "atanh", scope: !31, file: !31, line: 715, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!118 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !119, file: !41, line: 1078)
!119 = !DISubprogram(name: "atanhf", scope: !31, file: !31, line: 716, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!120 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !121, file: !41, line: 1079)
!121 = !DISubprogram(name: "atanhl", scope: !31, file: !31, line: 717, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!122 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !123, file: !41, line: 1081)
!123 = !DISubprogram(name: "cbrt", scope: !31, file: !31, line: 877, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!124 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !125, file: !41, line: 1082)
!125 = !DISubprogram(name: "cbrtf", scope: !31, file: !31, line: 878, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!126 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !127, file: !41, line: 1083)
!127 = !DISubprogram(name: "cbrtl", scope: !31, file: !31, line: 879, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!128 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !129, file: !41, line: 1085)
!129 = !DISubprogram(name: "copysign", scope: !31, file: !31, line: 1063, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!130 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !131, file: !41, line: 1086)
!131 = !DISubprogram(name: "copysignf", scope: !31, file: !31, line: 1064, type: !132, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!132 = !DISubroutineType(types: !133)
!133 = !{!98, !98, !98}
!134 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !135, file: !41, line: 1087)
!135 = !DISubprogram(name: "copysignl", scope: !31, file: !31, line: 1065, type: !136, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!136 = !DISubroutineType(types: !137)
!137 = !{!109, !109, !109}
!138 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !139, file: !41, line: 1089)
!139 = !DISubprogram(name: "erf", scope: !31, file: !31, line: 901, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!140 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !141, file: !41, line: 1090)
!141 = !DISubprogram(name: "erff", scope: !31, file: !31, line: 902, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!142 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !143, file: !41, line: 1091)
!143 = !DISubprogram(name: "erfl", scope: !31, file: !31, line: 903, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!144 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !145, file: !41, line: 1093)
!145 = !DISubprogram(name: "erfc", scope: !31, file: !31, line: 906, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!146 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !147, file: !41, line: 1094)
!147 = !DISubprogram(name: "erfcf", scope: !31, file: !31, line: 907, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!148 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !149, file: !41, line: 1095)
!149 = !DISubprogram(name: "erfcl", scope: !31, file: !31, line: 908, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!150 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !151, file: !41, line: 1097)
!151 = !DISubprogram(name: "exp2", scope: !31, file: !31, line: 728, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!152 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !153, file: !41, line: 1098)
!153 = !DISubprogram(name: "exp2f", scope: !31, file: !31, line: 729, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!154 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !155, file: !41, line: 1099)
!155 = !DISubprogram(name: "exp2l", scope: !31, file: !31, line: 730, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !157, file: !41, line: 1101)
!157 = !DISubprogram(name: "expm1", scope: !31, file: !31, line: 734, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!158 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !159, file: !41, line: 1102)
!159 = !DISubprogram(name: "expm1f", scope: !31, file: !31, line: 735, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!160 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !161, file: !41, line: 1103)
!161 = !DISubprogram(name: "expm1l", scope: !31, file: !31, line: 736, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!162 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !163, file: !41, line: 1105)
!163 = !DISubprogram(name: "fdim", scope: !31, file: !31, line: 1109, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!164 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !165, file: !41, line: 1106)
!165 = !DISubprogram(name: "fdimf", scope: !31, file: !31, line: 1110, type: !132, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!166 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !167, file: !41, line: 1107)
!167 = !DISubprogram(name: "fdiml", scope: !31, file: !31, line: 1111, type: !136, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!168 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !169, file: !41, line: 1109)
!169 = !DISubprogram(name: "fma", scope: !31, file: !31, line: 1130, type: !170, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!170 = !DISubroutineType(types: !171)
!171 = !{!40, !40, !40, !40}
!172 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !173, file: !41, line: 1110)
!173 = !DISubprogram(name: "fmaf", scope: !31, file: !31, line: 1131, type: !174, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!174 = !DISubroutineType(types: !175)
!175 = !{!98, !98, !98, !98}
!176 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !177, file: !41, line: 1111)
!177 = !DISubprogram(name: "fmal", scope: !31, file: !31, line: 1132, type: !178, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!178 = !DISubroutineType(types: !179)
!179 = !{!109, !109, !109, !109}
!180 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !181, file: !41, line: 1113)
!181 = !DISubprogram(name: "fmax", scope: !31, file: !31, line: 1119, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!182 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !183, file: !41, line: 1114)
!183 = !DISubprogram(name: "fmaxf", scope: !31, file: !31, line: 1120, type: !132, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!184 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !185, file: !41, line: 1115)
!185 = !DISubprogram(name: "fmaxl", scope: !31, file: !31, line: 1121, type: !136, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!186 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !187, file: !41, line: 1117)
!187 = !DISubprogram(name: "fmin", scope: !31, file: !31, line: 1124, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!188 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !189, file: !41, line: 1118)
!189 = !DISubprogram(name: "fminf", scope: !31, file: !31, line: 1125, type: !132, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!190 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !191, file: !41, line: 1119)
!191 = !DISubprogram(name: "fminl", scope: !31, file: !31, line: 1126, type: !136, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!192 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !193, file: !41, line: 1121)
!193 = !DISubprogram(name: "hypot", scope: !31, file: !31, line: 882, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!194 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !195, file: !41, line: 1122)
!195 = !DISubprogram(name: "hypotf", scope: !31, file: !31, line: 883, type: !132, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!196 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !197, file: !41, line: 1123)
!197 = !DISubprogram(name: "hypotl", scope: !31, file: !31, line: 887, type: !136, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!198 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !199, file: !41, line: 1125)
!199 = !DISubprogram(name: "ilogb", scope: !31, file: !31, line: 748, type: !200, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!200 = !DISubroutineType(types: !201)
!201 = !{!34, !40}
!202 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !203, file: !41, line: 1126)
!203 = !DISubprogram(name: "ilogbf", scope: !31, file: !31, line: 749, type: !204, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!204 = !DISubroutineType(types: !205)
!205 = !{!34, !98}
!206 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !207, file: !41, line: 1127)
!207 = !DISubprogram(name: "ilogbl", scope: !31, file: !31, line: 750, type: !208, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!208 = !DISubroutineType(types: !209)
!209 = !{!34, !109}
!210 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !211, file: !41, line: 1129)
!211 = !DISubprogram(name: "lgamma", scope: !31, file: !31, line: 911, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!212 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !213, file: !41, line: 1130)
!213 = !DISubprogram(name: "lgammaf", scope: !31, file: !31, line: 912, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!214 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !215, file: !41, line: 1131)
!215 = !DISubprogram(name: "lgammal", scope: !31, file: !31, line: 913, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!216 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !217, file: !41, line: 1134)
!217 = !DISubprogram(name: "llrint", scope: !31, file: !31, line: 946, type: !218, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!218 = !DISubroutineType(types: !219)
!219 = !{!220, !40}
!220 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!221 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !222, file: !41, line: 1135)
!222 = !DISubprogram(name: "llrintf", scope: !31, file: !31, line: 947, type: !223, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!223 = !DISubroutineType(types: !224)
!224 = !{!220, !98}
!225 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !226, file: !41, line: 1136)
!226 = !DISubprogram(name: "llrintl", scope: !31, file: !31, line: 948, type: !227, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!227 = !DISubroutineType(types: !228)
!228 = !{!220, !109}
!229 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !230, file: !41, line: 1138)
!230 = !DISubprogram(name: "llround", scope: !31, file: !31, line: 1038, type: !218, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!231 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !232, file: !41, line: 1139)
!232 = !DISubprogram(name: "llroundf", scope: !31, file: !31, line: 1039, type: !223, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!233 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !234, file: !41, line: 1140)
!234 = !DISubprogram(name: "llroundl", scope: !31, file: !31, line: 1040, type: !227, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!235 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !236, file: !41, line: 1143)
!236 = !DISubprogram(name: "log1p", scope: !31, file: !31, line: 768, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!237 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !238, file: !41, line: 1144)
!238 = !DISubprogram(name: "log1pf", scope: !31, file: !31, line: 769, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!239 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !240, file: !41, line: 1145)
!240 = !DISubprogram(name: "log1pl", scope: !31, file: !31, line: 770, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !242, file: !41, line: 1147)
!242 = !DISubprogram(name: "log2", scope: !31, file: !31, line: 773, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!243 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !244, file: !41, line: 1148)
!244 = !DISubprogram(name: "log2f", scope: !31, file: !31, line: 774, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !246, file: !41, line: 1149)
!246 = !DISubprogram(name: "log2l", scope: !31, file: !31, line: 775, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!247 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !248, file: !41, line: 1151)
!248 = !DISubprogram(name: "logb", scope: !31, file: !31, line: 778, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !250, file: !41, line: 1152)
!250 = !DISubprogram(name: "logbf", scope: !31, file: !31, line: 779, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!251 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !252, file: !41, line: 1153)
!252 = !DISubprogram(name: "logbl", scope: !31, file: !31, line: 780, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!253 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !254, file: !41, line: 1155)
!254 = !DISubprogram(name: "lrint", scope: !31, file: !31, line: 942, type: !255, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!255 = !DISubroutineType(types: !256)
!256 = !{!257, !40}
!257 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!258 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !259, file: !41, line: 1156)
!259 = !DISubprogram(name: "lrintf", scope: !31, file: !31, line: 943, type: !260, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!260 = !DISubroutineType(types: !261)
!261 = !{!257, !98}
!262 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !263, file: !41, line: 1157)
!263 = !DISubprogram(name: "lrintl", scope: !31, file: !31, line: 944, type: !264, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!264 = !DISubroutineType(types: !265)
!265 = !{!257, !109}
!266 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !267, file: !41, line: 1159)
!267 = !DISubprogram(name: "lround", scope: !31, file: !31, line: 1035, type: !255, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!268 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !269, file: !41, line: 1160)
!269 = !DISubprogram(name: "lroundf", scope: !31, file: !31, line: 1036, type: !260, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!270 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !271, file: !41, line: 1161)
!271 = !DISubprogram(name: "lroundl", scope: !31, file: !31, line: 1037, type: !264, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!272 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !273, file: !41, line: 1163)
!273 = !DISubprogram(name: "nan", scope: !31, file: !31, line: 1087, type: !274, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!274 = !DISubroutineType(types: !275)
!275 = !{!40, !276}
!276 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !277, size: 64)
!277 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !15)
!278 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !279, file: !41, line: 1164)
!279 = !DISubprogram(name: "nanf", scope: !31, file: !31, line: 1088, type: !280, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!280 = !DISubroutineType(types: !281)
!281 = !{!98, !276}
!282 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !283, file: !41, line: 1165)
!283 = !DISubprogram(name: "nanl", scope: !31, file: !31, line: 1089, type: !284, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!284 = !DISubroutineType(types: !285)
!285 = !{!109, !276}
!286 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !287, file: !41, line: 1167)
!287 = !DISubprogram(name: "nearbyint", scope: !31, file: !31, line: 931, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!288 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !289, file: !41, line: 1168)
!289 = !DISubprogram(name: "nearbyintf", scope: !31, file: !31, line: 932, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!290 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !291, file: !41, line: 1169)
!291 = !DISubprogram(name: "nearbyintl", scope: !31, file: !31, line: 933, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!292 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !293, file: !41, line: 1171)
!293 = !DISubprogram(name: "nextafter", scope: !31, file: !31, line: 1098, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!294 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !295, file: !41, line: 1172)
!295 = !DISubprogram(name: "nextafterf", scope: !31, file: !31, line: 1099, type: !132, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!296 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !297, file: !41, line: 1173)
!297 = !DISubprogram(name: "nextafterl", scope: !31, file: !31, line: 1100, type: !136, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!298 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !299, file: !41, line: 1175)
!299 = !DISubprogram(name: "nexttoward", scope: !31, file: !31, line: 1103, type: !300, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!300 = !DISubroutineType(types: !301)
!301 = !{!40, !40, !109}
!302 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !303, file: !41, line: 1176)
!303 = !DISubprogram(name: "nexttowardf", scope: !31, file: !31, line: 1104, type: !304, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!304 = !DISubroutineType(types: !305)
!305 = !{!98, !98, !109}
!306 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !307, file: !41, line: 1177)
!307 = !DISubprogram(name: "nexttowardl", scope: !31, file: !31, line: 1105, type: !136, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!308 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !309, file: !41, line: 1179)
!309 = !DISubprogram(name: "remainder", scope: !31, file: !31, line: 1053, type: !48, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!310 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !311, file: !41, line: 1180)
!311 = !DISubprogram(name: "remainderf", scope: !31, file: !31, line: 1054, type: !132, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!312 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !313, file: !41, line: 1181)
!313 = !DISubprogram(name: "remainderl", scope: !31, file: !31, line: 1055, type: !136, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!314 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !315, file: !41, line: 1183)
!315 = !DISubprogram(name: "remquo", scope: !31, file: !31, line: 1058, type: !316, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!316 = !DISubroutineType(types: !317)
!317 = !{!40, !40, !40, !68}
!318 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !319, file: !41, line: 1184)
!319 = !DISubprogram(name: "remquof", scope: !31, file: !31, line: 1059, type: !320, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!320 = !DISubroutineType(types: !321)
!321 = !{!98, !98, !98, !68}
!322 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !323, file: !41, line: 1185)
!323 = !DISubprogram(name: "remquol", scope: !31, file: !31, line: 1060, type: !324, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!324 = !DISubroutineType(types: !325)
!325 = !{!109, !109, !109, !68}
!326 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !327, file: !41, line: 1187)
!327 = !DISubprogram(name: "rint", scope: !31, file: !31, line: 937, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!328 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !329, file: !41, line: 1188)
!329 = !DISubprogram(name: "rintf", scope: !31, file: !31, line: 938, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!330 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !331, file: !41, line: 1189)
!331 = !DISubprogram(name: "rintl", scope: !31, file: !31, line: 939, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!332 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !333, file: !41, line: 1191)
!333 = !DISubprogram(name: "round", scope: !31, file: !31, line: 1030, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!334 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !335, file: !41, line: 1192)
!335 = !DISubprogram(name: "roundf", scope: !31, file: !31, line: 1031, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!336 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !337, file: !41, line: 1193)
!337 = !DISubprogram(name: "roundl", scope: !31, file: !31, line: 1032, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!338 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !339, file: !41, line: 1195)
!339 = !DISubprogram(name: "scalbln", scope: !31, file: !31, line: 871, type: !340, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!340 = !DISubroutineType(types: !341)
!341 = !{!40, !40, !257}
!342 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !343, file: !41, line: 1196)
!343 = !DISubprogram(name: "scalblnf", scope: !31, file: !31, line: 872, type: !344, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!344 = !DISubroutineType(types: !345)
!345 = !{!98, !98, !257}
!346 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !347, file: !41, line: 1197)
!347 = !DISubprogram(name: "scalblnl", scope: !31, file: !31, line: 873, type: !348, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!348 = !DISubroutineType(types: !349)
!349 = !{!109, !109, !257}
!350 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !351, file: !41, line: 1199)
!351 = !DISubprogram(name: "scalbn", scope: !31, file: !31, line: 867, type: !71, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!352 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !353, file: !41, line: 1200)
!353 = !DISubprogram(name: "scalbnf", scope: !31, file: !31, line: 868, type: !354, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!354 = !DISubroutineType(types: !355)
!355 = !{!98, !98, !34}
!356 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !357, file: !41, line: 1201)
!357 = !DISubprogram(name: "scalbnl", scope: !31, file: !31, line: 869, type: !358, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!358 = !DISubroutineType(types: !359)
!359 = !{!109, !109, !34}
!360 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !361, file: !41, line: 1203)
!361 = !DISubprogram(name: "tgamma", scope: !31, file: !31, line: 918, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!362 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !363, file: !41, line: 1204)
!363 = !DISubprogram(name: "tgammaf", scope: !31, file: !31, line: 919, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!364 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !365, file: !41, line: 1205)
!365 = !DISubprogram(name: "tgammal", scope: !31, file: !31, line: 920, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!366 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !367, file: !41, line: 1207)
!367 = !DISubprogram(name: "trunc", scope: !31, file: !31, line: 1044, type: !38, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!368 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !369, file: !41, line: 1208)
!369 = !DISubprogram(name: "truncf", scope: !31, file: !31, line: 1045, type: !103, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!370 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !29, entity: !371, file: !41, line: 1209)
!371 = !DISubprogram(name: "truncl", scope: !31, file: !31, line: 1046, type: !107, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!372 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !373, entity: !374, file: !375, line: 58)
!373 = !DINamespace(name: "__gnu_debug", scope: null)
!374 = !DINamespace(name: "__debug", scope: !29)
!375 = !DIFile(filename: "C:/AMDDesignTools/2026.1/Vitis/tps/mingw/8.3.0/win64.o/nt\5Clib\5Cgcc\5Cx86_64-w64-mingw32\5C8.3.0\5Cinclude\5Cc++\5Cdebug/debug.h", directory: "")
!376 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !25, entity: !29, file: !14, line: 5)
!377 = !DILocation(line: 9, column: 1, scope: !7)
