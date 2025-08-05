SCENE_DIR="../storage/data/360_v2"
RESULT_DIR="results/black_v2"
SCENE_LIST="garden"
CAP_MAX=1000000
ITERATION=30000
BLACK_ARGS="--black_iter 20000"
DATA_FACTOR=4
BLACK_THRESHOLD="0.0004 0.0006 0.0014 0.001 0.0002"

for SCENE in $SCENE_LIST;
do
    for THRESHOLD in $BLACK_THRESHOLD;
    do
        echo "Running $SCENE with threshold $THRESHOLD"
            python train.py -s $SCENE_DIR/$SCENE --cap_max $CAP_MAX -m $RESULT_DIR/$SCENE/$THRESHOLD -r $DATA_FACTOR --iterations $ITERATION $BLACK_ARGS \
            --black_threshold $THRESHOLD 
            python render.py --iteration $ITERATION -s $SCENE_DIR/$SCENE -m $RESULT_DIR/$SCENE/$THRESHOLD --eval --skip_train -r $DATA_FACTOR
    done
done