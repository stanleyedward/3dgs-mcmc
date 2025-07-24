SCENE_DIR="../storage/data/360_v2"
RESULT_DIR="results/black_v1"
SCENE_LIST="garden"
CAP_MAX=1000000
ITERATION=30000
BLACK_ARGS="--black_iter 20_000 --black_gradient_threshold 0.0002"

for SCENE in $SCENE_LIST;
do
    echo "Running $SCENE"
        python train.py -s $SCENE_DIR/$SCENE --cap_max $CAP_MAX -m $RESULT_DIR/$SCENE -r $DATA_FACTOR --iterations $ITERATION --outdoor $BLACK_ARGS
        python render.py --iteration $ITERATION -s $SCENE_DIR/$SCENE -m $RESULT_DIR/$SCENE --eval --skip_train -r $DATA_FACTOR
        # python metrics.py -m $RESULT_DIR/$SCENE
done