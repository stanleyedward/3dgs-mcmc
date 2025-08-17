SCENE_DIR="../storage/data/360_v2"
RESULT_DIR="results/black_diff_iterations"
SCENE_LIST="counter kitchen room bonsai"
# SCENE_LIST="counter"
CAP_MAX=1000000
ITERATION=15000
BLACK_ITER="10000"
DATA_FACTOR=4
BLACK_THRESHOLD="0.0004"

for SCENE in $SCENE_LIST;
do
    for ITER in $BLACK_ITER;
    do

	    for THRESHOLD in $BLACK_THRESHOLD;
	    do
		if [ "$SCENE" = "bonsai" ] || [ "$SCENE" = "counter" ] || [ "$SCENE" = "kitchen" ] || [ "$SCENE" = "room" ]; then
			DATA_FACTOR=4
		else
			DATA_FACTOR=4
		fi
		echo "Running $SCENE for rendering video"
			python create_video.py -m $RESULT_DIR/$SCENE/$ITER/$THRESHOLD -r $DATA_FACTOR
			rm -rf $RESULT_DIR/$SCENE/$ITER/$THRESHOLD/traj/renders
	    done
    done
done
