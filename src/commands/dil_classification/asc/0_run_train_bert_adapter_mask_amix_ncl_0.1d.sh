#!/bin/bash
#SBATCH -p gpu20
#SBATCH -t 15:00:00
#SBATCH -o dil_asc_adapter_mask_mixup_0-%j.out
#SBATCH --gres gpu:1


for id in 0
do
    python run.py \
    --bert_model 'bert-base-uncased' \
    --note random$id,amix,Attn-HCHP-Outside,distill_head,sup,augment_distill,selfattn,naug1,task_based,last_id,0.1d,10ep\
    --ntasks 19 \
    --nclasses 3 \
    --task asc \
    --scenario dil_classification \
    --idrandom $id \
    --approach bert_adapter_mask_ncl \
    --experiment bert \
    --apply_bert_output \
    --apply_bert_attention_output \
    --eval_batch_size 128 \
    --num_train_epochs 10 \
    --temp 1 \
    --base_temp 1 \
    --output_dir './OutputBert' \
    --augment_distill \
    --distill_head \
    --sup_loss \
    --amix \
    --attn_type self \
    --task_based \
    --mix_type Attn-HCHP-Outside \
    --naug 1 \
    --last_id \
    --down_sample_ratio 0.1
done
#--share_gate
#--nepochs 1
#    --train_batch_size 128 \
#-m torch.distributed.launch --nproc_per_node=2
#    --distributed \
#    --multi_gpu \
#    --ngpus 2
#    --pooled_rep_contrast \
#    --l2_norm \

#    --amix_head
#    --sup_head \