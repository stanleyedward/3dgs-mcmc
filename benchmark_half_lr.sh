SCENE_DIR="../storage/data/360_v2"
RESULT_DIR="results/mcmc_inria_benchmark/mipnerf/half_lr"
SCENE_LIST="garden bicycle stump bonsai counter kitchen room"
CAP_MAX=1000000
INIT="sfm"
ITERATION=30000
DATA_FACTOR=1

for SCENE in $SCENE_LIST;
do 
    if [ "$SCENE" = "bonsai" ] || [ "$SCENE" = "counter" ] || [ "$SCENE" = "kitchen" ] || [ "$SCENE" = "room" ]; then
        DATA_FACTOR=2
    else
        DATA_FACTOR=4
    fi
    echo "Running $SCENE with $INIT initializations"

    CUDA_VISIBLE_DEVICES=7 python train.py \
        -r $DATA_FACTOR \
        --cap_max $CAP_MAX \
        -s $SCENE_DIR/$SCENE/ \
        -m $RESULT_DIR/$SCENE/ \
        --iterations 30000 \
        --eval \
        --init_type $INIT \
        --position_lr_init 0.00008 \
        --position_lr_final 0.0000008 \
        --opacity_lr 0.025 \
        --scaling_lr 0.0025 \
        --rotation_lr 0.0005 \
        --noise_lr 25000 
    python render.py --iteration $ITERATION -s $SCENE_DIR/$SCENE -m $RESULT_DIR/$SCENE --eval --skip_train -r $DATA_FACTOR
    python metrics.py -m $RESULT_DIR/$SCENE

done