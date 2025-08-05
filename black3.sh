SCENE_DIR="../storage/data/360_v2"
RESULT_DIR="results/black_diff_iterations"
# SCENE_LIST="garden bicycle counter kitchen room stump bonsai"
SCENE_LIST="counter"
CAP_MAX=1000000
ITERATION=15000
BLACK_ITER="7000 10000"
DATA_FACTOR=4
BLACK_THRESHOLD="0.0004 0.0010 0.0014"

for SCENE in $SCENE_LIST;
do
    for ITER in $BLACK_ITER;
    do

	    for THRESHOLD in $BLACK_THRESHOLD;
	    do
		if [ "$SCENE" = "bonsai" ] || [ "$SCENE" = "counter" ] || [ "$SCENE" = "kitchen" ] || [ "$SCENE" = "room" ]; then
			DATA_FACTOR=2
		else
			DATA_FACTOR=4
		fi
		echo "Running $SCENE with threshold $THRESHOLD; optimizing till $ITER"
		    python train.py -s $SCENE_DIR/$SCENE --cap_max $CAP_MAX -m $RESULT_DIR/$SCENE/$ITER/$THRESHOLD -r $DATA_FACTOR --iterations $ITERATION --black_iter $ITER \
		    --black_threshold $THRESHOLD 
		    python render.py --iteration $ITERATION -s $SCENE_DIR/$SCENE -m $RESULT_DIR/$SCENE/$ITER/$THRESHOLD --eval --skip_train -r $DATA_FACTOR
	    done
    done
done
