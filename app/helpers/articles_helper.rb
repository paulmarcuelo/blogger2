module ArticlesHelper
    def article_params
        params.require(:article).permit(:title, :body, images: [])
    end
end
